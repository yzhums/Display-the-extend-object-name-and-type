pageextension 50122 AllObjectswithCaptionExt extends "All Objects with Caption"
{
    layout
    {
        addafter("Object Subtype")
        {
            field(ExtendObjectType; ExtendObjectType)
            {
                ApplicationArea = All;
                Caption = 'Extend Object Type';
            }
            field(ExtendObjectName; ExtendObjectName)
            {
                ApplicationArea = All;
                Caption = 'Extend Object Name';
            }
        }
    }

    var
        ExtendObjectType: Text[30];
        ExtendObjectName: Text[30];

    trigger OnAfterGetRecord()
    begin
        ExtendObjectType := '';
        ExtendObjectName := '';
        case Rec."Object Type" of
            Rec."Object Type"::"TableExtension":
                begin
                    ExtendObjectType := 'Table';
                    ExtendObjectName := GetObjectNameFromID(Rec."Object Type"::Table, Rec."Object Subtype")
                end;
            Rec."Object Type"::"PageExtension":
                begin
                    ExtendObjectType := 'Page';
                    ExtendObjectName := GetObjectNameFromID(Rec."Object Type"::Page, Rec."Object Subtype")
                end;
            Rec."Object Type"::ReportExtension:
                begin
                    ExtendObjectType := 'Report';
                    ExtendObjectName := GetObjectNameFromID(Rec."Object Type"::Report, Rec."Object Subtype")
                end;
            Rec."Object Type"::EnumExtension:
                begin
                    ExtendObjectType := 'Enum';
                    ExtendObjectName := GetObjectNameFromID(Rec."Object Type"::Enum, Rec."Object Subtype")
                end;
            Rec."Object Type"::PermissionSetExtension:
                begin
                    ExtendObjectType := 'PermissionSet';
                    ExtendObjectName := GetObjectNameFromID(Rec."Object Type"::PermissionSet, Rec."Object Subtype")
                end;
        end;
    end;

    local procedure GetObjectNameFromID("Object Type": option; "Object ID": Text[30]): Text[30]
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        if AllObjWithCaption.Get("Object Type", "Object ID") then
            exit(AllObjWithCaption."Object Name");
    end;
}
