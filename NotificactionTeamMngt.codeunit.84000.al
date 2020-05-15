codeunit 84000 "Notificaction Team Mngt."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Assembly Document", 'OnAfterReleaseAssemblyDoc', '', false, false)]
    local procedure SendNotificationAssemblyTeam(var AssemblyHeader: Record "Assembly Header")
    var
        NotificableTeam: Record "Notificable Team";
    begin
        with NotificableTeam do begin
            if not FindSet() then
                exit;
            SendTextToTeam(StrSubstNo(MessaTextAssembly, AssemblyHeader."No.",
                        AssemblyHeader.Description));

        end;
    end;

    var
        MessaTextAssembly: Label 'Order %1 %2 released';
}