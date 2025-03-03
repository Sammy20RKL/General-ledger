/* codeunit 50125 "Shoes Testing"
{

    TableNo=Customer;
    trigger OnRun();
    begin
        CheckSize(Rec);
    end;
    procedure CheckSize(var cust: Record Customer)

    begin
        if not cust.HasShoesSize() then
        cust.ShoesSize:=38;
    end;
    
    
} */
