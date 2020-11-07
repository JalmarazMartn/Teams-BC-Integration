table 84001 "Request Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(2; Certificate; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(3; User; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Password; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Url; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Consult Method"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date To"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Message No. Serie"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(10; "Vat Number Declaration"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; CAE; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Last Request"; Blob)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    procedure LoadCertificateWithFile()
    var
        InstrCertfica: InStream;
        OutstrCertificate: OutStream;
        NameFileCert: Text;
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        TextCert: Text;
    begin
        UploadIntoStream('', '', '(*.*)|*.*', NameFileCert, InstrCertfica);
        Clear(Certificate);
        Modify();
        Certificate.CreateOutStream(OutstrCertificate);
        OutstrCertificate.WriteText(Base64.ToBase64(InstrCertfica));
        Modify();
        Message(GetCerticateBase64());
    end;

    procedure GetCerticateBase64() Cert: Text
    var
        InstrCertificate: InStream;
    begin
        Certificate.CreateInStream(InstrCertificate);
        CalcFields(Certificate);
        InstrCertificate.ReadText(Cert);
    end;

    procedure GetNextIdMessage() NextId: code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        get;
        TestField("Message No. Serie");
        NextId := NoSeriesManagement.GetNextNo("Message No. Serie", WorkDate(), true);
        Commit();
    end;

}