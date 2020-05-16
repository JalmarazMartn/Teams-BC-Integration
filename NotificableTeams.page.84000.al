page 84000 "Notificable Teams"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Notificable Team";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field(URL; URL)
                {
                    ApplicationArea = All;
                }
                field("Teams Notification Area"; "Teams Notification Area")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}