codeunit 50100 "Merge Test"
{
    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        Convert64: Codeunit "Base64 Convert";
        MergePDF: Codeunit MergePDF;
        TempBlob: Codeunit "Temp Blob";
        TestMerge: Page "Test Merge";
        RecRef1: RecordRef;
        Ins: InStream;
        Outs: OutStream;
        Filename: Text;
        PdfText: Text;
    begin
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.FindFirst();
        SalesHeader.SetRange("No.", SalesHeader."No.");
        Recref1.GetTable(SalesHeader);
        MergePDF.AddReportToMerge(Report::"Standard Sales - Order Conf.", Recref1);

        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.FindFirst();
        SalesHeader.SetRange("No.", SalesHeader."No.");
        Recref1.GetTable(SalesHeader);
        MergePDF.AddReportToMerge(Report::"Standard Sales - Order Conf.", Recref1);

        TestMerge.SetMergePdf(MergePDF.GetJArray());
        TestMerge.RunModal();
        PdfText := TestMerge.GetMergedPdf();

        Filename := 'Test.pdf';
        TempBlob.CreateInStream(Ins);
        TempBlob.CreateOutStream(Outs);
        Convert64.FromBase64(PdfText, Outs);
        DownloadFromStream(Ins, 'Download', '', '', Filename);
    end;
}