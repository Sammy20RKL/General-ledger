tableextension 50140 "User Setup Table" extends "User Setup"
{
    fields
    {

        field(50140; "Journal Template Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template".Name;
            // TableRelation = "Gen. Journal Template" where(name = field("Journal Template Name"));
        }
        field(50141; "Journal Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));

            //     TableRelation="Gen. Journal Template" where ("Page ID"=field("Journal Batch Name"));
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}