table 84000 "Notificable Team"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Name; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; URL; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Teams Notification Area"; enum "Teams Notification Area")
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
    var
        JSONMessage: Label '{''text'':''%1''}';

    procedure SendTextToTeam(MessageText: text) ResponseText: Text
    var
        HttpClient: HttpClient;
        HttpContent: HttpContent;
        HttpResponseMessage: HttpResponseMessage;
    begin
        HttpContent.WriteFrom(StrSubstNo(JSONMessage, MessageText));
        HttpClient.Post(URL, HttpContent, HttpResponseMessage);
        HttpResponseMessage.Content.ReadAs(ResponseText);
    end;
}