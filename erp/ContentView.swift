import SwiftUI
import SwiftData
import MapKit
import CoreLocation


enum StatusArea: String, Codable, CaseIterable {
    case planejado = "Planejando"
    case plantado = "Plantado"
    case emDesenvolvimento = "Em Desenvolvimento"
    case colhido = "Colhido"
    case pousio = "Pousio"
    
    var cor: Color {
        switch self {
        case .planejado: return .secondary
        case .plantado: return .blue
        case .emDesenvolvimento: return .orange
        case .colhido: return .green
        case .pousio: return .brown
        }
    }

    var icone: String {
        switch self {
        case .planejado: return "map"
        case .plantado: return "arrow.down.to.line"
        case .emDesenvolvimento: return "leaf"
        case .colhido: return "checkmark.seal"
        case .pousio: return "moon.zzz"
        }
    }
}

enum CulturaAgro: String, Codable, CaseIterable {
    case soja = "Soja"
    case milho = "Milho"
    case trigo = "Trigo"
    case algodao = "Algodão"
    case cana = "Cana-de-açúcar"
    case cafe = "Café"
    case outros = "Outros"
}

@Model
class LancamentoCusto {
    var id: UUID
    var data: Date
    var descricao: String
    var valor: Double
    
    init(descricao: String, valor: Double) {
        self.id = UUID()
        self.data = Date()
        self.descricao = descricao
        self.valor = valor
    }
}

@Model
class Area {
    var id: UUID
    var nome: String
    var areaHectares: Double
    var culturaRaw: String
    var safra: String
    var statusRaw: String
    var lancamentos: [LancamentoCusto]
    var latitude: Double
    var longitude: Double
    
    init(nome: String, areaHectares: Double, cultura: CulturaAgro, safra: String, latitude: Double = 0, longitude: Double = 0) {
        self.id = UUID()
        self.nome = nome
        self.areaHectares = areaHectares
        self.culturaRaw = cultura.rawValue
        self.safra = safra
        self.statusRaw = StatusArea.planejado.rawValue
        self.lancamentos = []
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var status: StatusArea {
        get { StatusArea(rawValue: statusRaw ) ?? . planejado}
        set { statusRaw = newValue.rawValue }
    }
    
    var custoPorHactare: Double {areaHectares > 0 ? custoTotal / areaHectares : 0 }
    var custoLabel: String { custoPorHactare.formatted(.currency(code: "BRL")) + "/ha"}
    
    var hasLocation: Bool {latitude != 0 || longitude != 0}
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    var areaM2: Double {areaHectares * 10_000}
    var raioMetros: CLLocationDistance{sqrt(areaM2 / .pi)}
    var cultura: CulturaAgro {
        CulturaAgro(rawValue: culturaRaw) ?? .outros
    }
    
    var areaLabel: String {
        let m2 = areaM2
        let m2Str = m2 != 1_000 ? "\(String(format: "%.0f", m2 / 1_000)) k m2" : "\(String(format: "%.2f", m2)) m2"
        return "\(String(format: "%.2f", areaHectares)) ha . \(m2Str)"
    }
    
    
   var custoTotal: Double { lancamentos.reduce(0) { $0 + $1.valor } }
    
}

@Model
class Produtor {
    var id: UUID
    var nome: String
    var documento: String
    var municipio: String
    var estado: String
    var areas: [Area]
    
    init(nome: String, documento: String, municipio: String, estado: String) {
        self.id = UUID()
        self.nome = nome
        self.documento = documento
        self.municipio = municipio
        self.estado = estado
        self.areas = []
    }
    
    var areaTotal: Double { areas.reduce(0) {$0 + $1.areaHectares}}
    var custoTotal: Double {areas.reduce(0) {$0 + $1.custoTotal}}
    var custoMedioHa: Double {areaTotal > 0 ? custoTotal / areaTotal : 0 }
    
}


struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
           ProdutoresView()
                .tabItem { Label("Produtores", systemImage: "person.2.fill")}
            
            MapaGeralView()
                .tabItem {Label("Mapa", systemImage: "map.fill")}
        }
        .onAppear { seedAgro(context: context)}
    }
}
    


struct ProdutoresView: View {
    @Query(sort: \Produtor.nome) private var produtores: [Produtor]
    @State private var produtorSelecionado: Produtor?
    @State private var mostrarNovo = false
    var body: some View {
        
        NavigationStack {
            List(produtores) { prod in
                Button { produtorSelecionado = prod } label: {
                    ProdutorRow(produtor: prod)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Produtores")
            .toolbar {
                Button {mostrarNovo = true } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(item: $produtorSelecionado) {DetalheProdutorView(produtor: $0)}
            //.sheet(isPresented: $mostrarNovo) {NovoProdutorView}
        }
    }
}


struct ProdutorRow: View {
    let produtor: Produtor
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(produtor.nome).font(.headline)
                Text("\(produtor.municipio) , \(produtor.estado)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(String(format: "%.0f", produtor.areaTotal)) ha")
                    .font(.subheadline).bold()
                Text("\(produtor.areas.count) áreas")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    
            }

        }
        .padding(.vertical, 4)
    }
}

struct DetalheProdutorView: View {
    @Bindable var produtor: Produtor
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var areaSelecionada: Area?
    @State private var mostrarNovaArea = false
    @State private var mostrarMapa = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    LabeledContent("Documento", value: produtor.documento)
                    LabeledContent("Municipio", value: "\(produtor.municipio) - \(produtor.estado)")
                    LabeledContent("Área total", value: "\(String(format: "%.1f", produtor.areaTotal))")
                    LabeledContent("Custo total", value: produtor.custoTotal.formatted(.currency(code: "BRL")))
                    LabeledContent("Custo medio/ha", value: produtor.custoMedioHa.formatted(.currency(code: "BRL")))
                    
                    if produtor.areas.contains(where: {$0.hasLocation}) {
                        Button {
                            mostrarMapa = true
                        } label: {
                            Label("Ver áreas no mapa", systemImage: "map")
                        }
                    }
                    Section("Áreas \(produtor.areas.count)") {
                        ForEach(produtor.areas) { area in
                            Button { areaSelecionada = area} label: {
                                AreaRow(area: area)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        
                    }
                }
                .navigationTitle(produtor.nome)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
    
    struct AreaRow: View {
        let area: Area
        var body: some View {
            HStack {
                Image(systemName: area.status.icone)
                    .foregroundStyle(area.status.cor)
                    .frame(width: 20)
                VStack(alignment: .leading, spacing: 2){
                    Text(area.nome)
                        .font(.subheadline).bold()
                    HStack(spacing: 4) {
                        Text(area.culturaRaw)
                        Text(".")
                        Text("\(String(format: "%.1f", area.areaHectares)) ha")
                        
                        if area.hasLocation {
                            Image(systemName: "location.fill")
                                .font(.system(size: 9))
                                .foregroundStyle(.blue)
                        }
                        
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text(area.custoLabel)
                        .font(.subheadline).bold()
                    Text(area.status.rawValue)
                        .font(.caption)
                        .foregroundStyle(area.status.cor)
                }
            }
            .padding(.vertical, 2)
        }
    }



struct MapaGeralView: View {
    @Query private var areas: [Area]
    @Environment(\.dismiss) private var dismiss
    @State private var camera: MapCameraPosition = .automatic
    @State private var areaSelecionada: Area?
    @State private var estiloSatelite = true
    
    var areasComLoc: [Area] { areas.filter {$0.hasLocation}}
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(position: $camera) {
                    ForEach(areasComLoc) { a in
                        MapCircle(center: a.coordinate, radius: a.raioMetros)
                            .foregroundStyle(a.status.cor.opacity(0.2))
                            .stroke(a.status.cor, lineWidth: 2)
                        Annotation("", coordinate: a.coordinate){
                            AreaPin(area: a, selecionado: areaSelecionada?.id == a.id)
                                .onTapGesture{
                                    withAnimation {
                                        areaSelecionada = (areaSelecionada?.id == a.id) ? nil : a
                                    }
                                }
                        }
                    }
                }
                .mapStyle(estiloSatelite ? .hybrid(elevation: .realistic) : .standard)
                .ignoresSafeArea()
                
                VStack(spacing: 8){
                    if let a = areaSelecionada {
                        AreaMapCard(area: a) {
                            withAnimation {areaSelecionada = nil}
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.horizontal, 16)
                    }
                    
                    HStack{
                        Button {
                            withAnimation{estiloSatelite.toggle()}
                        } label: {
                            Image(systemName: estiloSatelite ? "map" : "globe.americas.fill")
                                .padding(8)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                }
               
            }
            .navigationTitle("Mapa de Áreas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Text("\(areasComLoc.count) áreas")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
            }
        }
    }
}


struct AreaPin: View {
    let area: Area
    let selecionado: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.background)
                .frame(width: selecionado ? 36 : 28, height: selecionado ? 36 : 28)
                .overlay(Circle().stroke(area.status.cor, lineWidth: selecionado ? 3 : 2))
            Image(systemName: area.status.icone)
                .font(.system(size: selecionado ? 14 : 11, weight: .semibold))
                .foregroundStyle(area.status.cor)
        }
        .animation(.spring(response: 0.25), value: selecionado)
    }
}
struct AreaMapCard: View {
    let area: Area
    let onDismiss: () -> Void
    @State private var mostrarDetalhe = false
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 4){
                    Text(area.nome).font(.headline)
                    HStack(spacing: 6) {
                        Label(area.status.rawValue, systemImage: area.status.icone)
                            .font(.caption)
                            .foregroundStyle(area.status.cor)
                        Text(".").foregroundStyle(.secondary)
                        Text(area.culturaRaw).font(.caption).foregroundStyle(.secondary)
                    }
                    HStack(spacing: 16) {
                        VStack(alignment: .leading){
                            Text("Área").font(.caption2).foregroundStyle(.secondary)
                            Text(String(format: "%.2f ha", area.areaHectares)).font(.subheadline).bold()
                        }
                        VStack(alignment: .leading){
                            Text("Custo/ha").font(.caption2).foregroundStyle(.secondary)
                            Text(area.custoLabel).font(.subheadline).bold()
                        }
                    }
                }
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                        .font(.title3)
                }
                }
            Button {mostrarDetalhe = true} label: {
                Label("Ver detalhes", systemImage: "list.bullet.clipboard")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding(16)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 8, y: 2)
        .sheet(isPresented: $mostrarDetalhe) {
            DetalheAreaView(area: area)
        }
    }
}

struct DetalheAreaView: View {
    @Bindable var area: Area
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var mostrarMapa = false
    @State private var mostrarPickerLoc = false
    
    var body: some View {
    

        NavigationStack {
            List {
                Section("Identificaçao") {
                    LabeledContent("Cultura", value: area.culturaRaw)
                    LabeledContent("Safra", value: area.safra)
                    LabeledContent("Área", value: area.areaLabel)
                    
                    HStack {
                        Text("Status")
                        Spacer()
                        Picker("", selection: Binding(
                            get: { area.status },
                            set: { area.status = $0; try? context.save() }
                        )) {
                            ForEach(StatusArea.allCases, id: \.self) { s in
                                Text(s.rawValue).tag(s)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .font(.subheadline)
                    
                }
                Section("Localizaçao") {
                    if area.hasLocation {
                        ZStack(alignment: .bottomTrailing) {
                            Map(initialPosition: .region(MKCoordinateRegion(
                                center: area.coordinate,
                                latitudinalMeters: area.raioMetros * 5,
                                longitudinalMeters: area.raioMetros * 5
                            )))
                            {
                                MapCircle(center: area.coordinate, radius: area.raioMetros)
                                    .foregroundStyle(area.status.cor.opacity(0.25))
                                    .stroke(area.status.cor, lineWidth: 2)
                                Annotation("", coordinate: area.coordinate) {
                                    AreaPin(area: area, selecionado: false)
                                }
                            }
                            .mapStyle(.hybrid)
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .disabled(true)
                            
                            Button { mostrarMapa = true } label: {
                                Image(systemName: "arrow.up.left.end.arrow.down.right")
                                    .padding(8)
                                    .background(.regularMaterial)
                                    .clipShape(Circle())
                                
                            }
                            .padding(8)
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        
                        LabeledContent("Latitude", value: String(format: "%.6f", area.latitude))
                        LabeledContent("Longitude", value: String(format: "%.6f", area.longitude))
                        LabeledContent("Raio equivalente", value: String(format: "%.0f m ", area.raioMetros))


                    }
                    Button { mostrarPickerLoc = true } label: {
                        Label(area.hasLocation ? "Ajustar localização" : "Definir localização", systemImage: area.hasLocation ? "location.fill" :"location.slash")
                    }
                    Section("Custo") {
                        LabeledContent("Total investido", value: area.custoTotal.formatted(.currency(code: "BRL")))
                        LabeledContent("Custo por hectare", value: area.custoLabel)
                        
                        
                    }
                }
            }
            
            
            // TODO: CONTINUAR PROXIMO VIDEO - PARTE 2
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Produtor.self, Area.self, LancamentoCusto.self],
        inMemory: true)
}
