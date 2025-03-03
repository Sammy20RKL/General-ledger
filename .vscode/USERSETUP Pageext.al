pageextension 50140 "User Setup Page" extends "User Setup"
{

    layout
    {
        addlast(Control1)
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the journal template name';
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the journal batch name';
            }
        }

    }


}