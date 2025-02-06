class MoteisModel {
  bool? sucesso;
  Data? data;

  MoteisModel({this.sucesso, this.data});

  MoteisModel.fromJson(Map<String, dynamic> json) {
    sucesso = json['sucesso'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'sucesso': sucesso,
      'data': data?.toJson(),
    };
  }
}

class Data {
  int? pagina;
  int? qtdPorPagina;
  int? totalSuites;
  int? totalMoteis;
  int? raio;
  int? maxPaginas;
  List<Moteis>? moteis;

  Data({
    this.pagina,
    this.qtdPorPagina,
    this.totalSuites,
    this.totalMoteis,
    this.raio,
    this.maxPaginas,
    this.moteis,
  });

  Data.fromJson(Map<String, dynamic> json) {
    pagina = (json['pagina'] as num?)?.toInt();
    qtdPorPagina = (json['qtdPorPagina'] as num?)?.toInt();
    totalSuites = (json['totalSuites'] as num?)?.toInt();
    totalMoteis = (json['totalMoteis'] as num?)?.toInt();
    raio = (json['raio'] as num?)?.toInt();
    maxPaginas = (json['maxPaginas'] as num?)?.toInt();
    if (json['moteis'] != null) {
      moteis = (json['moteis'] as List)
          .map((e) => Moteis.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'pagina': pagina,
      'qtdPorPagina': qtdPorPagina,
      'totalSuites': totalSuites,
      'totalMoteis': totalMoteis,
      'raio': raio,
      'maxPaginas': maxPaginas,
      'moteis': moteis?.map((e) => e.toJson()).toList(),
    };
  }
}

class Moteis {
  String? fantasia;
  String? logo;
  String? bairro;
  double? distancia;
  int? qtdFavoritos;
  List<Suites>? suites;
  int? qtdAvaliacoes;
  double? media;

  Moteis({
    this.fantasia,
    this.logo,
    this.bairro,
    this.distancia,
    this.qtdFavoritos,
    this.suites,
    this.qtdAvaliacoes,
    this.media,
  });

  Moteis.fromJson(Map<String, dynamic> json) {
    fantasia = json['fantasia'];
    logo = json['logo'];
    bairro = json['bairro'];
    distancia = (json['distancia'] as num?)?.toDouble();
    qtdFavoritos = (json['qtdFavoritos'] as num?)?.toInt();
    qtdAvaliacoes = (json['qtdAvaliacoes'] as num?)?.toInt();
    media = (json['media'] as num?)?.toDouble();
    if (json['suites'] != null) {
      suites = (json['suites'] as List)
          .map((e) => Suites.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'fantasia': fantasia,
      'logo': logo,
      'bairro': bairro,
      'distancia': distancia,
      'qtdFavoritos': qtdFavoritos,
      'qtdAvaliacoes': qtdAvaliacoes,
      'media': media,
      'suites': suites?.map((e) => e.toJson()).toList(),
    };
  }
}

class Suites {
  String? nome;
  int? qtd;
  bool? exibirQtdDisponiveis;
  List<String>? fotos;
  List<Itens>? itens;
  List<CategoriaItens>? categoriaItens;
  List<Periodos>? periodos;

  Suites({
    this.nome,
    this.qtd,
    this.exibirQtdDisponiveis,
    this.fotos,
    this.itens,
    this.categoriaItens,
    this.periodos,
  });

  Suites.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    qtd = (json['qtd'] as num?)?.toInt();
    exibirQtdDisponiveis = json['exibirQtdDisponiveis'];
    fotos = json['fotos'] != null ? List<String>.from(json['fotos']) : [];
    if (json['itens'] != null) {
      itens = (json['itens'] as List)
          .map((e) => Itens.fromJson(e))
          .toList();
    }
    if (json['categoriaItens'] != null) {
      categoriaItens = (json['categoriaItens'] as List)
          .map((e) => CategoriaItens.fromJson(e))
          .toList();
    }
    if (json['periodos'] != null) {
      periodos = (json['periodos'] as List)
          .map((e) => Periodos.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'qtd': qtd,
      'exibirQtdDisponiveis': exibirQtdDisponiveis,
      'fotos': fotos,
      'itens': itens?.map((e) => e.toJson()).toList(),
      'categoriaItens': categoriaItens?.map((e) => e.toJson()).toList(),
      'periodos': periodos?.map((e) => e.toJson()).toList(),
    };
  }
}

class Itens {
  String? nome;

  Itens({this.nome});

  Itens.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    return {'nome': nome};
  }
}

class CategoriaItens {
  String? nome;
  String? icone;

  CategoriaItens({this.nome, this.icone});

  CategoriaItens.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    icone = json['icone'];
  }

  Map<String, dynamic> toJson() {
    return {'nome': nome, 'icone': icone};
  }
}

class Periodos {
  String? tempoFormatado;
  String? tempo; // Aceito como String, converte de número se necessário
  double? valor;
  double? valorTotal;
  bool? temCortesia;
  Desconto? desconto;

  Periodos({
    this.tempoFormatado,
    this.tempo,
    this.valor,
    this.valorTotal,
    this.temCortesia,
    this.desconto,
  });

  Periodos.fromJson(Map<String, dynamic> json) {
    tempoFormatado = json['tempoFormatado'];
    tempo = json['tempo']?.toString();
    valor = (json['valor'] as num?)?.toDouble();
    valorTotal = (json['valorTotal'] as num?)?.toDouble();
    temCortesia = json['temCortesia'] is bool
        ? json['temCortesia']
        : json['temCortesia'] == 1;
    desconto = json['desconto'] != null && json['desconto'] is Map<String, dynamic>
        ? Desconto.fromJson(json['desconto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'tempoFormatado': tempoFormatado,
      'tempo': tempo,
      'valor': valor,
      'valorTotal': valorTotal,
      'temCortesia': temCortesia,
      'desconto': desconto?.toJson(),
    };
  }
}

class Desconto {
  double? desconto;

  Desconto({this.desconto});

  Desconto.fromJson(Map<String, dynamic> json) {
    desconto = (json['desconto'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'desconto': desconto};
  }
}
