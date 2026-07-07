//
//  QuotesAction.swift
//  OtusProfessional
//
//  Created by Alex on 16.06.2026.
//

import Foundation
import AnimechanAPI

enum QuotesAction {
    case screenAppeared
    case quoteAppeared(UUID)
    case reload
    case selectRubric(QuotesRubric)
    case showQueryDialog
    /// Обновить черновик ввода в диалоге.
    case updateQueryDraft(String)
    case cancelQueryDialog
    case confirmQueryDialog
    /// Пришёл батч цитат от API (результат middleware).
    case quotesLoaded([AnimechanQuote])
    /// Ошибка загрузки (результат middleware).
    case loadingFailed(String)
}
