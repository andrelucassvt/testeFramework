import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:testeframework/app/modules/home/models/produtos.dart';

class GeneratePDF {
  List<Produtos> produtos;
  GeneratePDF({
    @required this.produtos,
  });

  /// Cria e Imprime a fatura
  generatePDFInvoice() async {
    final pw.Document doc = pw.Document();
    final pw.Font customFont =
        pw.Font.ttf((await rootBundle.load('assets/RobotoSlabt.ttf')));
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
            margin: pw.EdgeInsets.zero,
            theme:
                pw.ThemeData(defaultTextStyle: pw.TextStyle(font: customFont))),
        header: _buildHeader,
        footer: _buildPrice,
        build: (context) => _buildContent(context),
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  /// Constroi o cabeçalho da página
  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
        color: PdfColors.blue,
        height: 150,
        child: pw.Padding(
            padding: pw.EdgeInsets.all(16),
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Padding(
                            padding: pw.EdgeInsets.all(8), child: pw.PdfLogo()),
                        pw.Text('Fatura',
                            style: pw.TextStyle(
                                fontSize: 22, color: PdfColors.white))
                      ]),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Comercio Digital',
                          style: pw.TextStyle(
                              fontSize: 22, color: PdfColors.white)),
                      pw.Text('Mauriti',
                          style: pw.TextStyle(color: PdfColors.white)),
                      pw.Text('Belém',
                          style: pw.TextStyle(color: PdfColors.white)),
                    ],
                  )
                ])));
  }

  /// Constroi o conteúdo da página
  List<pw.Widget> _buildContent(pw.Context context) {
    return [
      pw.Padding(
          padding: pw.EdgeInsets.only(top: 30, left: 25, right: 25),
          child: _buildContentClient()),
      pw.Padding(
          padding: pw.EdgeInsets.only(top: 50, left: 25, right: 25),
          child: _contentTable(context)),
    ];
  }

  pw.Widget _buildContentClient() {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _titleText('Cliente'),
              pw.Text('Cliente teste'),
              _titleText('Endereço'),
              pw.Text('Belém')
            ],
          ),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            _titleText('Número da fatura'),
            pw.Text('1222222'),
            _titleText('Data'),
            pw.Text(DateFormat('11/09/2001').format(DateTime.now()))
          ])
        ]);
  }

  _titleText(String text) {
    return pw.Padding(
        padding: pw.EdgeInsets.only(top: 8),
        child: pw.Text(text,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)));
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = ['Nome','Preço'];

    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(2),
      ),
      headerHeight: 25,
      cellHeight: 40,
      // Define o alinhamento das células, onde a chave é a coluna
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      // Define um estilo para o cabeçalho da tabela
      headerStyle: pw.TextStyle(
        fontSize: 10,
        color: PdfColors.blue,
        fontWeight: pw.FontWeight.bold,
      ),
      // Define um estilo para a célula
      cellStyle: const pw.TextStyle(
        fontSize: 10,
      ),
      // Define a decoração
      headers: tableHeaders,
      // retorna os valores da tabela, de acordo com a linha e a coluna
      data: List<List<String>>.generate(
        produtos.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => _getValueIndex(produtos[row], col),
        ),
      ),
    );
  }

  String _getValueIndex(Produtos product, int col) {
    switch (col) {
      case 0:
        return product.nome.toString();
      case 1:
        return product.preco.toString();
    }
    return '';
  }

  /// Retorna o QrCode da fatura
  pw.Widget _buildQrCode(pw.Context context) {
    return pw.Container(
        height: 65,
        width: 65,
        child: pw.BarcodeWidget(
            barcode: pw.Barcode.fromType(pw.BarcodeType.QrCode),
            data: 'invoice_id=${22245}',
            color: PdfColors.white));
  }

  /// Retorna o rodapé da página
  pw.Widget _buildPrice(pw.Context context) {
    return pw.Container(
      color: PdfColors.blue,
      height: 130,
      child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Padding(
                padding: pw.EdgeInsets.only(left: 16),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      _buildQrCode(context),
                      pw.Padding(
                          padding: pw.EdgeInsets.only(top: 12),
                          child: pw.Text('Use esse QR para pagar',
                              style: pw.TextStyle(
                                  color: PdfColor(0.85, 0.85, 0.85))))
                    ])),
            pw.Padding(
                padding: pw.EdgeInsets.all(16),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Padding(
                          padding: pw.EdgeInsets.only(bottom: 0),
                          child: pw.Text('TOTAL',
                              style: pw.TextStyle(color: PdfColors.white))),
                      pw.Text('R\$: 0000',
                          style: pw.TextStyle(
                              color: PdfColors.white, fontSize: 22))
                    ]))
          ]),
    );
  }
}