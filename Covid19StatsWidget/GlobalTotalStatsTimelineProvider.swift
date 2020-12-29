//
//  GlobalTotalStatsTimelineProvider.swift
//  Covid19StatsWidgetExtension
//
//  Created by Ngo Dang tan on 29/12/2020.
//

import Foundation
import WidgetKit

struct GlobalTotalStatsTimelineProvider: TimelineProvider {

    

    
    typealias Entry = TotalCaseEntry
    let service = Covid19APIService.shared
    func placeholder(in context: Context) -> TotalCaseEntry {
        TotalCaseEntry.placeholder
    }
    func getSnapshot(in context: Context, completion: @escaping (TotalCaseEntry) -> Void) {
        if context.isPreview {
            completion(TotalCaseEntry.placeholder)
        }else {
            fetchTotalGlobalCaseStats { result in
                switch result {
                case .success(let entry):
                    completion(entry)
                case .failure(_):
                    completion(TotalCaseEntry.placeholder)
                
                }
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TotalCaseEntry>) -> Void) {
        fetchTotalGlobalCaseStats { result in
            switch result {
            case .success(let entry):
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60*10)))
                completion(timeline)
            case .failure(_):
                let timeline = Timeline(entries: [TotalCaseEntry.placeholder], policy: .after(Date().addingTimeInterval(60*2)))
                completion(timeline)
            }
        }
    }
    
    private func fetchTotalGlobalCaseStats(completion: @escaping (Result<TotalCaseEntry,Error>) -> ()){
        service.getGlobalTotalCount { result in
            switch result {
            case . success(let stats):
                let entry = TotalCaseEntry(date: Date(), totalCount: .init(title: "🌍", confirmed: stats.totalConfirmed, death: stats.totalDeaths, recovered: stats.totalRecovered))
                completion(.success(entry))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
 
}
