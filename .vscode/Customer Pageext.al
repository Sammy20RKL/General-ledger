pageextension 50144 "Customer Page Process" extends "Customer List"
{


    actions
    {
        addlast(processing)
        {
            action("Process Annual Payment")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                trigger OnAction()
                var
                    Cust: Record Customer;
                begin
                    Cust.Reset();
                    Cust.SetRange("No.", Rec."No.");
                    if Cust.FindFirst() then
                        Report.Run(Report::"Process Annual Transaction", true, false, Cust);

                end;
            }
        }
    }

    var
        myInt: Integer;
}