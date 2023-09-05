codeunit 50201 MergePDF
{
    //HOW TO USE
    //Just call the AddReportToMerge or AddBase64pdf functions as many times as needed and later get call the GetJArray function.
    //You will get an array with all your pdfs in base64 to provide to the javascript function of the controladd-in

    procedure AddReportToMerge(ReportID: Integer; RecRef: RecordRef)
    var
        Convert: Codeunit "Base64 Convert";
        Tempblob: Codeunit "Temp Blob";
        Ins: InStream;
        Outs: OutStream;
        Parameters: Text;
    begin
        Tempblob.CreateInStream(Ins);
        Tempblob.CreateOutStream(Outs);
        Parameters := '';
        Report.SaveAs(ReportID, Parameters, ReportFormat::Pdf, Outs, RecRef);
        Clear(JObjectPDFToMerge);
        JObjectPDFToMerge.Add('pdf', Convert.ToBase64(Ins));
        JArrayPDFToMerge.Add(JObjectPDFToMerge);
    end;

    procedure AddBase64pdf(base64pdf: text)
    begin
        Clear(JObjectPDFToMerge);
        JObjectPDFToMerge.Add('pdf', base64pdf);
        JArrayPDFToMerge.Add(JObjectPDFToMerge);
    end;

    procedure ClearPDF()
    begin
        Clear(JArrayPDFToMerge);
    end;

    procedure GetJArray() JArrayPDF: JsonArray;
    begin
        JArrayPDF := JArrayPDFToMerge;
    end;

    var
        JArrayPDFToMerge: JsonArray;
        JObjectPDF: JsonObject;
        JObjectPDFToMerge: JsonObject;
}