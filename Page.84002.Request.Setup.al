page 84002 "Request Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Request Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Url; Url)
                {
                    ApplicationArea = All;

                }
                field(Password; Password)
                {
                    ApplicationArea = All;
                }
                field("Vat Number Declaration"; "Vat Number Declaration")
                {
                    ApplicationArea = all;
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = all;
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = all;
                }
                field(CAE; CAE)
                {
                    ApplicationArea = all;
                }
                field("Message No. Serie"; "Message No. Serie")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LoadFile)
            {
                ApplicationArea = All;
                Caption = 'Load Certificate';
                Image = MachineCenterLoad;
                trigger OnAction()
                begin
                    LoadCertificateWithFile();
                end;
            }
            action(SendConsult)
            {
                ApplicationArea = All;
                Caption = 'Send Consult';
                Image = SendTo;
                trigger OnAction()
                var
                    SendAndReceive: Codeunit "Send And Receive Consult";
                begin
                    SendAndReceive.SendConsult();
                end;
            }
            action(ViewXML)
            {
                ApplicationArea = All;
                Caption = 'View XML';
                Image = XMLFile;
                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"Consulta SILICIE");
                end;
            }

        }
    }
    trigger OnOpenPage()
    var

    begin
        if not get then
            Insert();
    end;

}