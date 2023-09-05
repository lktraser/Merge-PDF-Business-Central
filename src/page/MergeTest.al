page 50200 "Test Merge"
{
    Caption = 'Merging PDFs .....';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                usercontrol(PDFMerge; PDFMerge)
                {
                    ApplicationArea = all;

                    trigger DownloadPDF(pdfToNav: text)
                    var
                        Convert64: Codeunit "Base64 Convert";
                        TempBlob: Codeunit "Temp Blob";
                        Ins: InStream;
                        Outs: OutStream;
                        Filename: Text;
                    begin
                        PDFText := pdftoNav;
                        CurrPage.Close();
                    end;

                    trigger ControlAddInReady()
                    begin
                        RunMerge();
                    end;
                }
            }
        }
    }

    var
        PDFArray: JsonArray;
        PDFText: Text;

    internal procedure SetMergePdf(PDFArrayToSet: JsonArray)
    begin
        PDFArray := PDFArrayToSet;
    end;

    local procedure RunMerge()
    begin
        CurrPage.PDFMerge.MergePDF(Format(PDFArray));
    end;

    internal procedure GetMergedPdf(): Text
    begin
        exit(PDFText);
    end;
}