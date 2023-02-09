workspace workspace {

    model {
        customer = person "Customer"
        onlineBookStore = softwareSystem "Online book store" {
            webapp = container "Web Application" {
                loginController = component "login"
            }
            database = container "Database"
        }
        someApp = softwareSystem "my web app" {
            spaApp = container "SPA" "SPA App" "SPA"
        }
        
        someApi = softwareSystem "some API" {
            group "API A" {
                apiOne = container "API One" "First API" "APIM API" {
                    tags "API"
                    perspectives {
                        "API" "REST Service"
                    }
                }
                funcOne = container "Function One" "First Function" "Azure Function" {
                    perspectives {
                        "Backend" "Azure Fuction"
                    }
                }
            }
            group "API B" {
            
                funcTwo = container "Function Two" "Second Function" "Azure Function" {
                    perspectives {
                        "Backend" "Azure Fuction"
                    }
                }
                apiTwo = container "API Two" "Second API" "APIM API" {
                    tags "API"
                    perspectives {
                        "API" "REST Service"
                    }
                }
            }
        }

        customer -> webapp "Browses and makes purchases using"
        webapp -> database "Reads from and writes to"
        spaApp -> apiOne "Gets date from" "HTTPS/JSON"
        spaApp -> apiTwo "Posts data to" "HTTPS/JSON"
        funcOne -> apiOne "Backend service for API"
        funcTwo -> apiTwo "Backend service for API"
    }

    views {
        
        container someApi {
            include *
            autoLayout
        }
        
        container onlineBookStore {
            include *
            autoLayout lr
        }
        
        container someApp {
            include * 
            autoLayout
        }
        
        dynamic onlineBookStore {
            title "Request past orders feature"
            customer -> webapp "Requests past orders from"
            webapp -> database "Queries for orders using"
            autoLayout lr
        }
        
        dynamic onlineBookStore {
            title "Browse top 20 books feature"
            customer -> webapp "Requests the top 20 books from"
            webapp -> database "Queries the top 20 books using"
            autoLayout lr
        }
        
        styles {
            element "Group" {
                color #ff0000
            }
        }
    }
    
}