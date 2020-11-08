codeunit 84004 "Send And Receive Consult"
{
    trigger OnRun()
    begin

    end;

    procedure SendConsult()
    var
        XMLResponse: XmlDocument;
        XMLAgencyNumber: XmlNode;
    begin
        XMLResponse := GetSOPAServiceResponse();
        if XMLResponse.SelectSingleNode(LocalName('NumeroAsiento'), XMLAgencyNumber) then
            Message(XMLAgencyNumber.AsXmlElement().InnerXml);
    end;

    procedure GetSOPAServiceResponse() XMLResponse: XmlDocument;
    var
        SOAPRequest: HttpRequestMessage;
        SOAPResponse: HttpResponseMessage;
        ReqSetup: Record "Request Setup";
        SOAPClient: HttpClient;
        TextResp: Text;
    begin
        ReqSetup.get;
        ReqSetup.TestField(url);
        ReqSetup.TestField(Password);
        InitSOAPRequest(SOAPRequest, ReqSetup.Url);
        SOAPClient.AddCertificate(ReqSetup.GetCerticateBase64(), ReqSetup.Password);
        GrabarPeticion2(SOAPRequest);
        SOAPRequest.Method := 'POST';
        SOAPRequest.SetRequestUri(ReqSetup.Url);
        //if SOAPClient.Post(ReqSetup.Url, SOAPRequest.Content, SOAPResponse) then begin
        if SOAPClient.Send(SOAPRequest, SOAPResponse) then begin
            SOAPResponse.Content.ReadAs(TextResp);
            XmlDocument.ReadFrom(TextResp, XMLResponse);
        end;
    end;

    procedure InitSOAPRequest(var SOAPRequest: HttpRequestMessage; URL: Text[250])
    var
        SOAPHeader: HttpHeaders;

    begin
        SOAPRequest.GetHeaders(SOAPHeader);
        SOAPHeader.Add('ContentType', 'text/xml; charset="utf-8"');
        SOAPHeader.Add('Accept', 'text/xml,text/html');
        SOAPHeader.Add('SOAPAction', '""');
    end;

    local procedure GrabarPeticion2(var SOAPRequest: HttpRequestMessage)
    var
        ConsultaSILICIE: XmlPort "Consulta SILICIE";
        OutStream: OutStream;
        InStream: InStream;
        TextReq: Text;
        RequestSetup: Record "Request Setup";
        TempReq: record "Request Setup" temporary;
    begin
        TempReq.Insert();
        TempReq."Last Request".CreateOutStream(OutStream);
        ConsultaSILICIE.SetIdMessage(RequestSetup.GetNextIdMessage());
        ConsultaSILICIE.SETDESTINATION(OutStream);
        ConsultaSILICIE.EXPORT;
        TempReq.Modify();
        TempReq."Last Request".CreateInStream(InStream);
        TempReq.CalcFields("Last Request");
        InStream.Read(TextReq);
        SoapRequest.Content.WriteFrom(TextReq);
    end;

    local procedure LocalName(NodeName: text[100]): Text;
    begin
        exit(StrSubstNo('//*[local-name()="%1"]', NodeName));
    end;
}