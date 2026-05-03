# OtusProfessional

iOS-приложение для домашних заданий курса OTUS.

## Домашнее задание 1 — Навигация в SwiftUI

Демонстрация основных паттернов навигации в SwiftUI.

### Что реализовано

- **TabView** — три вкладки: Главная, Список, Модалка
- **NavigationStack** — список цветов с программной навигацией (`NavigationLink` + `navigationDestination`)
- **Modal Sheet** — показ модального окна через `.sheet`
- Программный переход между вкладками (`selection` через `@State`)

### Структура проекта

```
OtusProfessional/
├── OtusProfessionalApp.swift   — точка входа
├── ContentView.swift           — корневой контейнер
├── MainTabView.swift           — TabView с тремя вкладками
├── ColorDetail.swift           — экран детали цвета
└── features/
    ├── Enums.swift             — AppTab, ColorItem
    ├── NavigationList.swift    — список с NavigationStack
    └── ModalSheet.swift        — кнопка и модальный экран
```

### Требования

- iOS 18+
- Xcode 16+
- Swift 5.10+
