controladdin PDFMerge
{
    MaximumHeight = 1;
    MaximumWidth = 1;
    Scripts = 'src/script/pdf-lib.min.js',
    'src/script/download.js',
    'src/script/scripts.js';

    StartupScript = 'src/script/startup.js';

    event DownloadPDF(stringpdffinal: text);
    event ControlAddInReady();
    procedure MergePDF(JObjectToMerge: text);
}