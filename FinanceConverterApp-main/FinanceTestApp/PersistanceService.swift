//
//  PersistanceService.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 03.11.2023.
//

import Foundation
import UIKit
import CoreData

class PersistenceService {
    
    static let shared = PersistenceService()
    
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinanceTestApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var viewContext = persistentContainer.viewContext
    
    
    // MARK: - save context method
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllExchangeRates() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Response")
         fetchRequest.returnsObjectsAsFaults = false
         do {
             let results = try viewContext.fetch(fetchRequest)
             for object in results {
                 guard let objectData = object as? NSManagedObject else {continue}
                viewContext.delete(objectData)
             }
         } catch let error {
             print("Detele all data in Country error :", error)
         }
    }
    
    func saveExchangeRateData(data: ExchangeRateResponse) {

           if let entity = NSEntityDescription.entity(forEntityName: "Response", in: viewContext) {
               let exchangeRateObject = NSManagedObject(entity: entity, insertInto: viewContext)

               exchangeRateObject.setValue(data.success, forKey: "success")
               exchangeRateObject.setValue(data.timestamp, forKey: "timestamp")
               exchangeRateObject.setValue(data.base, forKey: "base")
               exchangeRateObject.setValue(data.date, forKey: "date")
               exchangeRateObject.setValue(data.rates, forKey: "rates")
               // Здесь можно добавить логику для сохранения rates
               do {
                   saveContext()
                   print("Данные успешно сохранены в Core Data")
               } catch {
                   print("Ошибка при сохранении данных в Core Data: \(error.localizedDescription)")
               }
           }
        
        
       }
    
    func loadExchangeRateData() -> [ExchangeRateResponse] {
        
//        let fetchRequest = Response.fetchRequest()
//        var savedTasks: [ExchangeRateResponse] = []
//        do {
//            let tasks = try viewContext.fetch(fetchRequest)
//            for taskEntity in tasks {
//                savedTasks.append(ExchangeRateResponse(
//                    success: taskEntity,
//                    timestamp: result.value(forKey: "timestamp") as? Int ?? 0,
//                    base: result.value(forKey: "base") as? String ?? "",
//                    date: result.value(forKey: "date") as? String ?? "",
//                    rates: result.value(forKey: "rates") as? [String: Double] ?? ["EUR": 1.0]
//                    // Здесь можно добавить логику для загрузки rates
//                ))
//            }
//        } catch {
//            print(error)
//        }
//        return savedTasks

        let fetchRequest = Response.fetchRequest()

            do {
                let results = try viewContext.fetch(fetchRequest)
                    var exchangeRateDataArray: [ExchangeRateResponse] = []
                    print("RESULT \(results.count)")

                    for result in results {
                        let exchangeRateData = ExchangeRateResponse(
                            success: result.value(forKey: "success") as? Bool ?? false,
                            timestamp: result.value(forKey: "timestamp") as? Int ?? 0,
                            base: result.value(forKey: "base") as? String ?? "",
                            date: result.value(forKey: "date") as? String ?? "",
                            rates: result.value(forKey: "rates") as? [String: Double] ?? ["EUR": 1.0]
                            // Здесь можно добавить логику для загрузки rates
                        )

                        exchangeRateDataArray.append(exchangeRateData)
                    }
                
//                if exchangeRateDataArray.count == 0 {
//                    let decoder = JSONDecoder()
//                    let data = returnMock().data(using: .utf8)
//                    let jsonData = try decoder.decode(ExchangeRateResponse.self, from: data ?? Data())
//                    PersistenceService.shared.saveExchangeRateData(data: jsonData)
//                    return [jsonData]
//                }

                    return exchangeRateDataArray
                
            } catch {
                print("Ошибка при загрузке данных из Core Data: \(error.localizedDescription)")
            }

            return []
        }
    

    // MARK: - save methods
    func saveNewCountry(country: CountryEntity) {
        let countryEntity = Country(context: viewContext)
        countryEntity.id = country.id
        countryEntity.name = country.name
        saveContext()
    }
    
    
    func deleteCountry(country: CountryEntity){
        let fetchRequest = Country.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: country.id))
        do {
            let countries = try viewContext.fetch(fetchRequest)
            
            
            if let taskEntity = countries.first {
                viewContext.delete(taskEntity)
                
                do {
                    try viewContext.save() // Сохранить изменения
                    print("Объект успешно удален")
                } catch {
                    print("Ошибка при сохранении контекста: \(error)")
                }
            } else {
                print("Объект не найден")
            }
            //            viewContext.delete(taskEntity)
            saveContext()
            
        } catch {
            print(error)
        }
    }

    func getCountries() -> [CountryEntity] {
        let fetchRequest = Country.fetchRequest()
        var savedTasks: [CountryEntity] = []
        do {
            let tasks = try viewContext.fetch(fetchRequest)
            for taskEntity in tasks {
                savedTasks.append(CountryEntity(id: taskEntity.id, name: taskEntity.name ?? " "))
            }
        } catch {
            print(error)
        }
        return savedTasks
    }
    
    func deleteAllCountries() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
         fetchRequest.returnsObjectsAsFaults = false
         do {
             let results = try viewContext.fetch(fetchRequest)
             for object in results {
                 guard let objectData = object as? NSManagedObject else {continue}
                viewContext.delete(objectData)
             }
         } catch let error {
             print("Detele all data in Country error :", error)
         }
    }
    
    func returnMock() -> String {
        var currentTimeStamp = Int(Date().timeIntervalSince1970)
        return """
 {"success":true,"timestamp":\(currentTimeStamp),"base":"EUR","date":"2023-11-07","rates":{"AED":3.930623,"AFN":78.654107,"ALL":104.499649,"AMD":430.906035,"ANG":1.927127,"AOA":885.087125,"ARS":374.423322,"AUD":1.66327,"AWG":1.926267,"AZN":1.81929,"BAM":1.959284,"BBD":2.15904,"BDT":117.889652,"BGN":1.95655,"BHD":0.403477,"BIF":3048.852014,"BMD":1.070148,"BND":1.450179,"BOB":7.389383,"BRL":5.214805,"BSD":1.069302,"BTC":3.0306153e-5,"BTN":89.026434,"BWP":14.449697,"BYN":3.522364,"BYR":20974.903293,"BZD":2.155433,"CAD":1.473176,"CDF":2767.402889,"CHF":0.962702,"CLF":0.034374,"CLP":948.493292,"CNY":7.790148,"COP":4293.787435,"CRC":571.134372,"CUC":1.070148,"CUP":28.358925,"CVE":110.894144,"CZK":24.626213,"DJF":190.186823,"DKK":7.458506,"DOP":60.913244,"DZD":143.988567,"EGP":32.957566,"ERN":16.052222,"ETB":59.457757,"EUR":1,"FJD":2.42506,"FKP":0.863733,"GBP":0.869996,"GEL":2.894767,"GGP":0.863733,"GHS":12.777562,"GIP":0.863733,"GMD":71.994193,"GNF":9256.781313,"GTQ":8.370887,"GYD":223.725185,"HKD":8.368398,"HNL":26.470124,"HRK":7.671846,"HTG":141.932409,"HUF":378.532638,"IDR":16739.845587,"ILS":4.14966,"IMP":0.863733,"INR":89.07073,"IQD":1401.894047,"IRR":45189.891346,"ISK":150.50572,"JEP":0.863733,"JMD":166.275701,"JOD":0.759061,"JPY":160.887131,"KES":162.07431,"KGS":95.585984,"KHR":4425.063004,"KMF":492.800909,"KPW":963.131227,"KRW":1396.473706,"KWD":0.330366,"KYD":0.891085,"KZT":497.87541,"LAK":22205.573985,"LBP":16089.677487,"LKR":350.142686,"LRD":200.757933,"LSL":21.033771,"LTL":3.159869,"LVL":0.647322,"LYD":5.195598,"MAD":10.947078,"MDL":19.178106,"MGA":4826.367919,"MKD":61.729779,"MMK":2245.493334,"MNT":3696.944741,"MOP":8.612917,"MRO":382.042697,"MUR":47.248968,"MVR":16.459531,"MWK":1201.241707,"MXN":18.703616,"MYR":4.961743,"MZN":67.686815,"NAD":20.996063,"NGN":841.767961,"NIO":39.204902,"NOK":11.975494,"NPR":142.437307,"NZD":1.802809,"OMR":0.411947,"PAB":1.069302,"PEN":4.025365,"PGK":3.974958,"PHP":60.103818,"PKR":304.992014,"PLN":4.459992,"PYG":7978.188229,"QAR":3.896142,"RON":4.968165,"RSD":117.234851,"RUB":98.557686,"RWF":1317.352345,"SAR":4.01489,"SBD":9.002952,"SCR":14.255635,"SDG":641.557082,"SEK":11.683661,"SGD":1.449623,"SHP":1.302102,"SLE":21.974042,"SLL":21135.424982,"SOS":611.05456,"SRD":40.704691,"STD":22149.905612,"SYP":13913.933533,"SZL":19.705726,"THB":38.032671,"TJS":11.719542,"TMT":3.75622,"TND":3.367218,"TOP":2.548451,"TRY":30.50247,"TTD":7.260149,"TWD":34.449464,"TZS":2673.229724,"UAH":38.524711,"UGX":4021.151124,"USD":1.070148,"UYU":42.596748,"UZS":13136.068277,"VEF":3762625.485713,"VES":37.661651,"VND":26031.353193,"VUV":129.569029,"WST":2.963025,"XAF":657.125617,"XAG":0.04727,"XAU":0.000543,"XCD":2.892129,"XDR":0.813346,"XOF":653.326095,"XPF":119.589208,"YER":267.911774,"ZAR":19.628553,"ZMK":9632.617845,"ZMW":24.033527,"ZWL":344.58726}}
 """
    }
    
}

enum APIResult<T> {
    case success(T)
    case failure(Error)
}
