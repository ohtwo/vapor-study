import Vapor

func routes(_ app: Application) throws {
  app.get { req async in
    "It works!"
  }

  app.get("hello", ":name") { req async throws -> String in
    guard let name = req.parameters.get("name") else {
      throw Abort(.internalServerError)
    }
    return "Hello, \(name)!"
  }
  
  app.post("info") { req -> InfoResponse in
    let data = try req.content.decode(InfoData.self)
    return InfoResponse(request: data)
  }
}

struct InfoData: Content {
 let name: String
}

struct InfoResponse: Content {
 let request: InfoData
}
