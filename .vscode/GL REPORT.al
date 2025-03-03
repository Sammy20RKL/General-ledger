report 50128 "Process Annual Transaction"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;
    Caption = 'Process Transaction';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(Name; Name)
            {

            }

            trigger OnAfterGetRecord()
            var
                CustPaymentAmnt: Decimal;
                CustCharge: Decimal;
                CustTax: Decimal;
                CustOutPayment: Decimal;
            begin
                CustPaymentAmnt := 40000;
                CustCharge := CustPaymentAmnt * 0.05;
                CustTax := CustPaymentAmnt * 0.16;
                CustOutPayment := 7500;

                LineNo += 1;
                GenJourLine.Init();
                GenJourLine."Line No." := LineNo;
                GenJourLine."Journal Template Name" := UserSetup."Journal Template Name";
                GenJourLine."Journal Batch Name" := UserSetup."Journal Batch Name";
                GenJourLine."Posting Date" := Today;
                GenJourLine."Document No." := DocumentNo;
                GenJourLine."Document Date" := Today;
                GenJourLine."Account Type" := GenJourLine."Account Type"::Customer;
                GenJourLine.Validate("Account No.", Customer."No.");
                GenJourLine.Description := 'Annual Payments' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenJourLine.Validate(Amount, -CustPaymentAmnt);
                GenJourLine."Currency Code" := '';
                GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                GenJourLine."Bal. Account No." := ExpenseGLAcc;
                GenJourLine.Insert();

                LineNo += 1;
                GenJourLine.Init();
                GenJourLine."Line No." := LineNo;
                GenJourLine."Journal Template Name" := UserSetup."Journal Template Name";
                GenJourLine."Journal Batch Name" := UserSetup."Journal Batch Name";
                GenJourLine."Posting Date" := Today;
                GenJourLine."Document No." := DocumentNo;
                GenJourLine."Document Date" := Today;
                GenJourLine."Account Type" := GenJourLine."Account Type"::Customer;
                GenJourLine.Validate("Account No.", Customer."No.");
                GenJourLine.Description := 'Annual Payments Charges' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenJourLine.Validate(Amount, (CustOutPayment + CustCharge + CustTax));
                GenJourLine."Currency Code" := '';
                GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                GenJourLine."Bal. Account No." := '';
                GenJourLine.Insert();

                LineNo += 1;
                GenJourLine.Init();
                GenJourLine."Line No." := LineNo;
                GenJourLine."Journal Template Name" := UserSetup."Journal Template Name";
                GenJourLine."Journal Batch Name" := UserSetup."Journal Batch Name";
                GenJourLine."Posting Date" := Today;
                GenJourLine."Document No." := DocumentNo;
                GenJourLine."Document Date" := Today;
                GenJourLine."Account Type" := GenJourLine."Account Type"::"G/L Account";
                GenJourLine.Validate("Account No.", PaymentGLAcc);
                GenJourLine.Description := 'OutStanding Payments' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenJourLine.Validate(Amount, -(CustOutPayment));
                GenJourLine."Currency Code" := '';
                GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                GenJourLine."Bal. Account No." := '';
                GenJourLine.Insert();

                LineNo += 1;
                GenJourLine.Init();
                GenJourLine."Line No." := LineNo;
                GenJourLine."Journal Template Name" := UserSetup."Journal Template Name";
                GenJourLine."Journal Batch Name" := UserSetup."Journal Batch Name";
                GenJourLine."Posting Date" := Today;
                GenJourLine."Document No." := DocumentNo;
                GenJourLine."Document Date" := Today;
                GenJourLine."Account Type" := GenJourLine."Account Type"::"G/L Account";
                GenJourLine.Validate("Account No.", FeesIncomeGLAcc);
                GenJourLine.Description := 'Annual Payments Charges' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenJourLine.Validate(Amount, -(CustCharge));
                GenJourLine."Currency Code" := '';
                GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                GenJourLine."Bal. Account No." := '';
                GenJourLine.Insert();

                LineNo += 1;
                GenJourLine.Init();
                GenJourLine."Line No." := LineNo;
                GenJourLine."Journal Template Name" := UserSetup."Journal Template Name";
                GenJourLine."Journal Batch Name" := UserSetup."Journal Batch Name";
                GenJourLine."Posting Date" := Today;
                GenJourLine."Document No." := DocumentNo;
                GenJourLine."Document Date" := Today;
                GenJourLine."Account Type" := GenJourLine."Account Type"::"G/L Account";
                GenJourLine.Validate("Account No.", TaxGLAcc);
                GenJourLine.Description := 'Annual Payments Taxes' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenJourLine.Validate(Amount, -(CustTax));
                GenJourLine."Currency Code" := '';
                GenJourLine."Bal. Account Type" := GenJourLine."Bal. Account Type"::"G/L Account";
                GenJourLine."Bal. Account No." := '';
                GenJourLine.Insert();



            end;

        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    field(ExpenseGLAcc; ExpenseGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expense G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));
                    }
                    field(FeesIncomeGLAcc; FeesIncomeGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fees Income G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));
                    }
                    field(TaxGLAcc; TaxGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tax G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));

                    }
                    field(PaymentGLAcc; PaymentGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document No.';
                    }
                    field(PostDirectly; PostDirectly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Directly.';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if ExpenseGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Expense G/L Acc'));
        if FeesIncomeGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Fees Income G/L Acc'));
        if TaxGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Tax G/L Acc'));
        if PaymentGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Payment G/L Acc'));
        if DocumentNo = '' then Error(StrSubstNo(RequiredErr, 'Document No.'));
        UserSetup.Get(UserId);
        UserSetup.TestField("Journal Template Name");
        UserSetup.TestField("Journal Batch Name");
        GenJourLine.Reset();
        GenJourLine.SetRange("Journal Template Name", UserSetup."Journal Template Name");
        GenJourLine.SetRange("Journal Batch Name", UserSetup."Journal Batch Name");
        if GenJourLine.FindFirst() then
            GenJourLine.DeleteAll();



    end;

    trigger OnPostReport()
    begin
        GenJourLine.Reset();
        GenJourLine.SetRange("Journal Template Name", UserSetup."Journal Template Name");
        GenJourLine.SetRange("Journal Batch Name", UserSetup."Journal Batch Name");
        if GenJourLine.FindFirst() then begin
            if not PostDirectly then
                Page.Run(Page::"General Journal", GenJourLine)
            else
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJourLine);
        end;
    end;

    /* rendering
    {
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    } */

    var
        ExpenseGLAcc: Code[40];
        FeesIncomeGLAcc: Code[30];
        PaymentGLAcc: Code[25];
        TaxGLAcc: Code[20];
        DocumentNo: Code[20];
        GenJourLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PostDirectly: Boolean;
        UserSetup: Record "User Setup";
        RequiredErr: Label 'Please enter the %1, field';
}