import Foundation
import Apollo
import KeychainSwift
import ApolloSQLite

class Network {
    static let shared = Network()
    let url = URL(string: Constants.urlStr)!
    
    private(set) lazy var apollo = ApolloClient(url: url)

    private(set) lazy var apolloSQLite: ApolloClient = {
        do {
            let documentsPath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentsPath.appendingPathComponent("apollo_cache.sqlite")
            let sqliteCache = try SQLiteNormalizedCache(fileURL: fileUrl)
            let store = ApolloStore(cache: sqliteCache)

            let client = URLSessionClient()
            let provider = NetworkInterceptorProvider(client: client, store: store)
            let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                         endpointURL: url)
            return ApolloClient(networkTransport: transport,
                                store: store)
        } catch {
            print("Error creating ApolloSQLite Client: \(error)")
            return apollo
        }
    }()
}
class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    let keychain = KeychainSwift()
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        if let token = keychain.get(AuthManager.loginKeychainKey) {
            request.addHeader(name: "Authorization", value: "Bearer \(token)")
        }
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
