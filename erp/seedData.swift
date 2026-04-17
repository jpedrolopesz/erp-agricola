import SwiftData


func seedAgro(context: ModelContext) {
    let fetchProd = FetchDescriptor<Produtor>()
    
    guard (try? context.fetch(fetchProd))?.isEmpty == true else { return }
    
    struct DadosArea {
        let nome: String
        let area: Double
        let cultura: CulturaAgro
        let status: StatusArea
        let lat: Double
        let lon: Double
        let lancamentos: [(String, Double)]
    }
    
    struct DadosProdutor {
        let nome: String
        let doc: String
        let municipio: String
        let estado: String
        let areas: [DadosArea]
    }
    
    let safra = "2024/2025"
    
    let todos: [DadosProdutor] = [

        // ACRE - AC
        DadosProdutor(
            nome: "Antônio Maia",
            doc: "001.002.003-04",
            municipio: "Rio Branco",
            estado: "AC",
            areas: [
                DadosArea(nome: "Fazenda Juruá", area: 85.0, cultura: .outros, status: .plantado,
                          lat: -9.9750, lon: -67.8243, lancamentos: [("Plantio", 9200), ("Manejo", 4100)]),
                DadosArea(nome: "Sítio Seringal", area: 40.0, cultura: .cafe, status: .emDesenvolvimento,
                          lat: -9.9900, lon: -67.8400, lancamentos: [("Adubação", 3200)])
            ]
        ),

        // ALAGOAS - AL
        DadosProdutor(
            nome: "Beatriz Lira",
            doc: "002.003.004-05",
            municipio: "Arapiraca",
            estado: "AL",
            areas: [
                DadosArea(nome: "Fazenda Caatinga", area: 110.0, cultura: .cana, status: .colhido,
                          lat: -9.7526, lon: -36.6616, lancamentos: [("Plantio", 11000), ("Colheita", 18500)]),
                DadosArea(nome: "Área do Brejo", area: 60.5, cultura: .milho, status: .pousio,
                          lat: -9.7700, lon: -36.6800, lancamentos: [("Preparo do solo", 4800)])
            ]
        ),

        // AMAPÁ - AP
        DadosProdutor(
            nome: "Cláudio Ferreira",
            doc: "003.004.005-06",
            municipio: "Macapá",
            estado: "AP",
            areas: [
                DadosArea(nome: "Fazenda Equatorial", area: 95.0, cultura: .soja, status: .planejado,
                          lat: 0.0349, lon: -51.0694, lancamentos: [("Planejamento", 5500)]),
                DadosArea(nome: "Talhão Cerrado", area: 70.0, cultura: .milho, status: .plantado,
                          lat: 0.0200, lon: -51.0800, lancamentos: [("Plantio", 7800), ("Adubação", 3200)])
            ]
        ),

        // AMAZONAS - AM
        DadosProdutor(
            nome: "Dalva Nogueira",
            doc: "004.005.006-07",
            municipio: "Parintins",
            estado: "AM",
            areas: [
                DadosArea(nome: "Roça do Lago", area: 55.0, cultura: .outros, status: .emDesenvolvimento,
                          lat: -2.6274, lon: -56.7358, lancamentos: [("Manejo", 4500), ("Adubação", 2100)]),
                DadosArea(nome: "Várzea Bela", area: 30.0, cultura: .milho, status: .colhido,
                          lat: -2.6400, lon: -56.7500, lancamentos: [("Colheita", 6200)])
            ]
        ),

        // BAHIA - BA
        DadosProdutor(
            nome: "Mariana Oliveira",
            doc: "321.654.987-00",
            municipio: "Luís Eduardo Magalhães",
            estado: "BA",
            areas: [
                DadosArea(nome: "Fazenda Oeste", area: 410.7, cultura: .algodao, status: .emDesenvolvimento,
                          lat: -12.0900, lon: -45.7800, lancamentos: [("Plantio", 43000), ("Adubação", 21000)]),
                DadosArea(nome: "Área Experimental", area: 95.2, cultura: .soja, status: .emDesenvolvimento,
                          lat: -12.0950, lon: -45.7850, lancamentos: [("Testes", 5000)])
            ]
        ),

        // CEARÁ - CE
        DadosProdutor(
            nome: "Evanildo Pinheiro",
            doc: "006.007.008-09",
            municipio: "Sobral",
            estado: "CE",
            areas: [
                DadosArea(nome: "Fazenda Sertão", area: 130.0, cultura: .milho, status: .planejado,
                          lat: -3.6861, lon: -40.3497, lancamentos: [("Planejamento", 6000)]),
                DadosArea(nome: "Área Irrigada", area: 75.0, cultura: .outros, status: .emDesenvolvimento,
                          lat: -3.7000, lon: -40.3600, lancamentos: [("Irrigação", 9500), ("Adubação", 4200)])
            ]
        ),

        // DISTRITO FEDERAL - DF
        DadosProdutor(
            nome: "Flávia Drummond",
            doc: "007.008.009-10",
            municipio: "Brasília",
            estado: "DF",
            areas: [
                DadosArea(nome: "Fazenda Planaltina", area: 180.0, cultura: .soja, status: .colhido,
                          lat: -15.4528, lon: -47.6396, lancamentos: [("Plantio", 19000), ("Colheita", 27000)]),
                DadosArea(nome: "Área Cerrado", area: 90.0, cultura: .milho, status: .pousio,
                          lat: -15.4700, lon: -47.6500, lancamentos: [("Preparo do solo", 7000)])
            ]
        ),

        // ESPÍRITO SANTO - ES
        DadosProdutor(
            nome: "Gustavo Rangel",
            doc: "008.009.010-11",
            municipio: "Cachoeiro de Itapemirim",
            estado: "ES",
            areas: [
                DadosArea(nome: "Fazenda Capixaba", area: 160.0, cultura: .cafe, status: .emDesenvolvimento,
                          lat: -20.8491, lon: -41.1134, lancamentos: [("Plantio", 14000), ("Pulverização", 6800)]),
                DadosArea(nome: "Sítio Verde Mar", area: 70.0, cultura: .milho, status: .colhido,
                          lat: -20.8600, lon: -41.1300, lancamentos: [("Colheita", 9500)])
            ]
        ),

        // GOIÁS - GO
        DadosProdutor(
            nome: "Helenice Castro",
            doc: "009.010.011-12",
            municipio: "Rio Verde",
            estado: "GO",
            areas: [
                DadosArea(nome: "Fazenda Planalto", area: 350.0, cultura: .soja, status: .plantado,
                          lat: -17.7973, lon: -50.9289, lancamentos: [("Plantio", 37000), ("Adubação", 16000)]),
                DadosArea(nome: "Talhão Milharal", area: 210.0, cultura: .milho, status: .emDesenvolvimento,
                          lat: -17.8100, lon: -50.9400, lancamentos: [("Plantio", 22000)])
            ]
        ),

        // MARANHÃO - MA
        DadosProdutor(
            nome: "Iracema Portela",
            doc: "010.011.012-13",
            municipio: "Balsas",
            estado: "MA",
            areas: [
                DadosArea(nome: "Fazenda Gerais", area: 390.0, cultura: .soja, status: .colhido,
                          lat: -7.5320, lon: -46.0353, lancamentos: [("Plantio", 41000), ("Colheita", 59000)]),
                DadosArea(nome: "Área Norte", area: 180.0, cultura: .milho, status: .planejado,
                          lat: -7.5500, lon: -46.0500, lancamentos: [("Planejamento", 8500)])
            ]
        ),

        // MATO GROSSO - MT
        DadosProdutor(
            nome: "João Batista",
            doc: "456.789.123-00",
            municipio: "Sorriso",
            estado: "MT",
            areas: [
                DadosArea(nome: "Fazenda Mato Verde", area: 500.0, cultura: .soja, status: .colhido,
                          lat: -12.5423, lon: -55.7211, lancamentos: [("Plantio", 50000), ("Colheita", 72000)]),
                DadosArea(nome: "Talhão 2", area: 320.0, cultura: .algodao, status: .colhido,
                          lat: -12.5500, lon: -55.7300, lancamentos: [("Planejamento", 15000)])
            ]
        ),

        // MATO GROSSO DO SUL - MS
        DadosProdutor(
            nome: "Juliana Menezes",
            doc: "012.013.014-15",
            municipio: "Dourados",
            estado: "MS",
            areas: [
                DadosArea(nome: "Fazenda Pantaneira", area: 440.0, cultura: .soja, status: .plantado,
                          lat: -22.2211, lon: -54.8056, lancamentos: [("Plantio", 46000), ("Adubação", 19000)]),
                DadosArea(nome: "Área Cana", area: 200.0, cultura: .cana, status: .emDesenvolvimento,
                          lat: -22.2400, lon: -54.8200, lancamentos: [("Plantio", 20000)])
            ]
        ),

        // MINAS GERAIS - MG
        DadosProdutor(
            nome: "Ricardo Mendes",
            doc: "159.753.486-00",
            municipio: "Uberlândia",
            estado: "MG",
            areas: [
                DadosArea(nome: "Fazenda Triângulo", area: 275.0, cultura: .milho, status: .pousio,
                          lat: -18.9146, lon: -48.2754, lancamentos: [("Plantio", 18000), ("Colheita", 26000)]),
                DadosArea(nome: "Área Sul", area: 140.0, cultura: .soja, status: .emDesenvolvimento,
                          lat: -18.9200, lon: -48.2800, lancamentos: [("Adubação", 9000)])
            ]
        ),

        // PARÁ - PA
        DadosProdutor(
            nome: "Leandro Tavares",
            doc: "014.015.016-17",
            municipio: "Santarém",
            estado: "PA",
            areas: [
                DadosArea(nome: "Fazenda Tapajós", area: 420.0, cultura: .soja, status: .colhido,
                          lat: -2.4426, lon: -54.7082, lancamentos: [("Plantio", 44000), ("Colheita", 63000)]),
                DadosArea(nome: "Área Floresta", area: 150.0, cultura: .outros, status: .emDesenvolvimento,
                          lat: -2.4600, lon: -54.7300, lancamentos: [("Manejo", 11000)])
            ]
        ),

        // PARAÍBA - PB
        DadosProdutor(
            nome: "Mônica Azevedo",
            doc: "015.016.017-18",
            municipio: "Patos",
            estado: "PB",
            areas: [
                DadosArea(nome: "Fazenda Semiárido", area: 100.0, cultura: .milho, status: .planejado,
                          lat: -7.0244, lon: -37.2742, lancamentos: [("Planejamento", 5200)]),
                DadosArea(nome: "Área Algodão", area: 80.0, cultura: .algodao, status: .emDesenvolvimento,
                          lat: -7.0400, lon: -37.2900, lancamentos: [("Plantio", 8900), ("Pulverização", 3900)])
            ]
        ),

        // PARANÁ - PR
        DadosProdutor(
            nome: "Fernanda Souza",
            doc: "987.654.321-00",
            municipio: "Cascavel",
            estado: "PR",
            areas: [
                DadosArea(nome: "Fazenda Horizonte", area: 200.0, cultura: .soja, status: .plantado,
                          lat: -24.9555, lon: -53.4552, lancamentos: [("Plantio", 20000), ("Pulverização", 9500)]),
                DadosArea(nome: "Área Norte", area: 150.3, cultura: .trigo, status: .emDesenvolvimento,
                          lat: -24.9600, lon: -53.4600, lancamentos: [("Preparo do solo", 7800)])
            ]
        ),

        // PERNAMBUCO - PE
        DadosProdutor(
            nome: "Nilson Cavalcanti",
            doc: "017.018.019-20",
            municipio: "Petrolina",
            estado: "PE",
            areas: [
                DadosArea(nome: "Fazenda São Francisco", area: 220.0, cultura: .outros, status: .emDesenvolvimento,
                          lat: -9.3891, lon: -40.5027, lancamentos: [("Irrigação", 16000), ("Adubação", 8300)]),
                DadosArea(nome: "Área Uva e Manga", area: 95.0, cultura: .outros, status: .colhido,
                          lat: -9.4000, lon: -40.5100, lancamentos: [("Colheita", 21000)])
            ]
        ),

        // PIAUÍ - PI
        DadosProdutor(
            nome: "Osvaldo Carneiro",
            doc: "018.019.020-21",
            municipio: "Bom Jesus",
            estado: "PI",
            areas: [
                DadosArea(nome: "Fazenda Cerrado Piauiense", area: 360.0, cultura: .soja, status: .plantado,
                          lat: -9.0733, lon: -44.3597, lancamentos: [("Plantio", 38000), ("Adubação", 17000)]),
                DadosArea(nome: "Talhão Milho", area: 190.0, cultura: .milho, status: .pousio,
                          lat: -9.0900, lon: -44.3700, lancamentos: [("Colheita", 23000)])
            ]
        ),

        // RIO DE JANEIRO - RJ
        DadosProdutor(
            nome: "Patrícia Rocha",
            doc: "019.020.021-22",
            municipio: "Campos dos Goytacazes",
            estado: "RJ",
            areas: [
                DadosArea(nome: "Fazenda Fluminense", area: 170.0, cultura: .cana, status: .emDesenvolvimento,
                          lat: -21.7545, lon: -41.3244, lancamentos: [("Plantio", 17500), ("Adubação", 7800)]),
                DadosArea(nome: "Área Norte Fluminense", area: 85.0, cultura: .milho, status: .colhido,
                          lat: -21.7700, lon: -41.3400, lancamentos: [("Colheita", 12000)])
            ]
        ),

        // RIO GRANDE DO NORTE - RN
        DadosProdutor(
            nome: "Quintino Alves",
            doc: "020.021.022-23",
            municipio: "Mossoró",
            estado: "RN",
            areas: [
                DadosArea(nome: "Fazenda Agreste", area: 115.0, cultura: .outros, status: .plantado,
                          lat: -5.1877, lon: -37.3442, lancamentos: [("Plantio", 10200), ("Irrigação", 6500)]),
                DadosArea(nome: "Área Melão", area: 55.0, cultura: .outros, status: .colhido,
                          lat: -5.2000, lon: -37.3600, lancamentos: [("Colheita", 14500)])
            ]
        ),

        // RIO GRANDE DO SUL - RS
        DadosProdutor(
            nome: "Rosane Becker",
            doc: "021.022.023-24",
            municipio: "Passo Fundo",
            estado: "RS",
            areas: [
                DadosArea(nome: "Fazenda Gaúcha", area: 290.0, cultura: .trigo, status: .colhido,
                          lat: -28.2620, lon: -52.4063, lancamentos: [("Plantio", 30000), ("Colheita", 44000)]),
                DadosArea(nome: "Área Soja Sul", area: 240.0, cultura: .soja, status: .plantado,
                          lat: -28.2800, lon: -52.4200, lancamentos: [("Plantio", 25000), ("Adubação", 11000)])
            ]
        ),

        // RONDÔNIA - RO
        DadosProdutor(
            nome: "Sandro Vieira",
            doc: "022.023.024-25",
            municipio: "Ji-Paraná",
            estado: "RO",
            areas: [
                DadosArea(nome: "Fazenda Rondônia Verde", area: 310.0, cultura: .soja, status: .emDesenvolvimento,
                          lat: -10.8784, lon: -61.9542, lancamentos: [("Plantio", 33000), ("Adubação", 14000)]),
                DadosArea(nome: "Talhão Café", area: 120.0, cultura: .cafe, status: .plantado,
                          lat: -10.8900, lon: -61.9700, lancamentos: [("Plantio", 13500)])
            ]
        ),

        // RORAIMA - RR
        DadosProdutor(
            nome: "Telma Bonifácio",
            doc: "023.024.025-26",
            municipio: "Boa Vista",
            estado: "RR",
            areas: [
                DadosArea(nome: "Fazenda Lavrado", area: 200.0, cultura: .soja, status: .planejado,
                          lat: 2.8235, lon: -60.6758, lancamentos: [("Planejamento", 9000)]),
                DadosArea(nome: "Área Arroz", area: 130.0, cultura: .outros, status: .emDesenvolvimento,
                          lat: 2.8100, lon: -60.6900, lancamentos: [("Plantio", 12500), ("Adubação", 5600)])
            ]
        ),

        // SANTA CATARINA - SC
        DadosProdutor(
            nome: "Ursula Zimmermann",
            doc: "024.025.026-27",
            municipio: "Chapecó",
            estado: "SC",
            areas: [
                DadosArea(nome: "Fazenda Oeste Catarinense", area: 185.0, cultura: .milho, status: .colhido,
                          lat: -27.0994, lon: -52.6152, lancamentos: [("Plantio", 19500), ("Colheita", 28000)]),
                DadosArea(nome: "Área Soja SC", area: 140.0, cultura: .soja, status: .emDesenvolvimento,
                          lat: -27.1100, lon: -52.6300, lancamentos: [("Adubação", 10000)])
            ]
        ),

        // SÃO PAULO - SP
        DadosProdutor(
            nome: "Carlos Andrade",
            doc: "123.456.789-00",
            municipio: "Ribeirão Preto",
            estado: "SP",
            areas: [
                DadosArea(nome: "Fazenda Boa Vista", area: 120.5, cultura: .soja, status: .emDesenvolvimento,
                          lat: -21.1704, lon: -47.8103, lancamentos: [("Plantio", 12320), ("Adubação", 8450)]),
                DadosArea(nome: "Sítio Primavera", area: 80.0, cultura: .cana, status: .pousio,
                          lat: -21.1800, lon: -47.8200, lancamentos: [("Colheita", 15400)])
            ]
        ),

        // SERGIPE - SE
        DadosProdutor(
            nome: "Vanessa Melo",
            doc: "026.027.028-29",
            municipio: "Lagarto",
            estado: "SE",
            areas: [
                DadosArea(nome: "Fazenda Sergipana", area: 90.0, cultura: .milho, status: .colhido,
                          lat: -10.9166, lon: -37.6530, lancamentos: [("Plantio", 9500), ("Colheita", 14000)]),
                DadosArea(nome: "Área Cana SE", area: 65.0, cultura: .cana, status: .emDesenvolvimento,
                          lat: -10.9300, lon: -37.6700, lancamentos: [("Plantio", 7200)])
            ]
        ),

        // TOCANTINS - TO
        DadosProdutor(
            nome: "Wanderley Fonseca",
            doc: "027.028.029-30",
            municipio: "Gurupi",
            estado: "TO",
            areas: [
                DadosArea(nome: "Fazenda Araguaia", area: 380.0, cultura: .soja, status: .plantado,
                          lat: -11.7298, lon: -49.0653, lancamentos: [("Plantio", 40000), ("Adubação", 18000)]),
                DadosArea(nome: "Talhão Milho TO", area: 210.0, cultura: .milho, status: .emDesenvolvimento,
                          lat: -11.7400, lon: -49.0800, lancamentos: [("Plantio", 22000), ("Pulverização", 8500)])
            ]
        )
    ]
    
    for dp in todos {
        let prod = Produtor(
            nome: dp.nome,
            documento: dp.doc,
            municipio: dp.municipio,
            estado: dp.estado
        )
        context.insert(prod)
        
        for da in dp.areas {
            
            let area = Area(
                nome: da.nome,
                areaHectares: da.area,
                cultura: da.cultura,
                safra: safra,
                latitude: da.lat,
                longitude: da.lon
                )
            
            area.status = da.status
            context.insert(area)
            
            for (desc, val) in da.lancamentos {
                let lancamento = LancamentoCusto(descricao: desc, valor: val)
                context.insert(lancamento)
                area.lancamentos.append(lancamento)
            }
            prod.areas.append(area)
                
        }
    }
    try? context.save()
}
