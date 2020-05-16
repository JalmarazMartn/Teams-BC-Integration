codeunit 84000 "Notificaction Team Mngt."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Assembly Document", 'OnAfterReleaseAssemblyDoc', '', false, false)]
    local procedure SendNotificationAssemblyTeam(var AssemblyHeader: Record "Assembly Header")
    var
        NotificableTeam: Record "Notificable Team";
    begin
        with NotificableTeam do begin
            SetRange("Teams Notification Area", "Teams Notification Area"::Assembly);
            if not FindSet() then
                exit;
            SendTextToTeam(StrSubstNo(MessaTextAssembly, AssemblyHeader."No.",
                        AssemblyHeader.Description));

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure SendNotificationSalesOrder(var SalesHeader: Record "Sales Header")
    var
        NotificableTeam: Record "Notificable Team";
    begin
        with NotificableTeam do begin
            SetRange("Teams Notification Area", "Teams Notification Area"::"Sales orders");
            if not FindSet() then
                exit;
            SendTextToTeam(StrSubstNo(MessaTextSalesDoc, SalesHeader."Document Type",
                        SalesHeader."No.", SalesHeader."Sell-to Customer Name"));

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure SendNotificationPurchOrder(var PurchaseHeader: Record "Purchase Header")
    var
        NotificableTeam: Record "Notificable Team";
    begin
        with NotificableTeam do begin
            SetRange("Teams Notification Area", "Teams Notification Area"::"Purchase Orders");
            if not FindSet() then
                exit;
            SendTextToTeam(StrSubstNo(MessaTextPurchDoc, PurchaseHeader."Document Type",
                        PurchaseHeader."No.", PurchaseHeader."Buy-from Vendor Name"));

        end;
    end;

    var
        MessaTextAssembly: Label 'Assembly Order %1 %2 released';
        MessaTextSalesDoc: Label 'Sales document %1 %2 customer %3 released';
        MessaTextPurchDoc: Label 'Purchase document %1 %2 vendor %3 released';

}