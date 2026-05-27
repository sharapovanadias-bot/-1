# LinguaTravel (Telegram Mini App)

Готовый шаблон Telegram Mini App на `Node.js + TypeScript` для Cursor.

## Что реализовано

- Структура из 5 папок: `src`, `models`, `views`, `controllers`, `utils`.
- 3 экрана: приветствие, переводчик, обучение.
- Telegram-команды: `/start`, `/translate`, `/learn`.
- Webhook endpoint для Telegram: `POST /telegram/webhook`.
- Mini App UI: `GET /miniapp`.

## Быстрый старт

1. Установите Node.js 20+.
2. Скопируйте `.env.example` в `.env` и заполните:
   - `TELEGRAM_BOT_TOKEN`
   - `PUBLIC_BASE_URL`
   - `PORT`
   - `DB_PROVIDER` (`sqlite` или `postgres`)
3. Установите зависимости:
   - `npm install`
4. Dev-режим:
   - `npm run dev`

## Продакшн

1. `npm run build`
2. `npm start`

## Хранение истории в БД

- История переводов и профиль пользователя сохраняются в БД (не в памяти).
- Поддерживаются два режима:
  - `DB_PROVIDER=sqlite` + `SQLITE_PATH=./data/linguatravel.db`
  - `DB_PROVIDER=postgres` + `POSTGRES_URL=postgresql://...`
- Таблицы (`users`, `translations`) создаются автоматически при старте сервера.

## Настройка Telegram

1. Создайте бота через [@BotFather](https://t.me/BotFather).
2. Получите токен и добавьте в `.env`.
3. Укажите публичный URL сервера в `PUBLIC_BASE_URL` (Vercel/Render/Heroku и т.д.).
4. Для локального запуска webhook установится автоматически при старте сервера.
5. Для Vercel установите webhook вручную:
   - `GET ${PUBLIC_BASE_URL}/telegram/setup-webhook?token=<TELEGRAM_SETUP_TOKEN>`
   - endpoint webhook: `${PUBLIC_BASE_URL}/telegram/webhook`

## Что заменить для AI-персонализации

- Реальный перевод уже подключен в `utils/translator.ts`.
- Доступные провайдеры:
  - `TRANSLATOR_PROVIDER=deepl` (по умолчанию)
  - `TRANSLATOR_PROVIDER=openai`
- Для DeepL укажите `DEEPL_API_KEY`.
- Для OpenAI укажите `OPENAI_API_KEY` (и при необходимости `OPENAI_MODEL`).
- При ошибке внешнего API используется безопасный fallback-ответ, чтобы UI не ломался.

## Деплой на Vercel

- В проект добавлен `vercel.json` и serverless entrypoint `api/index.ts`.
- Все роуты проксируются в Express app через Vercel Function.
- Добавьте переменные окружения в Vercel Project Settings:
  - `TELEGRAM_BOT_TOKEN`, `PUBLIC_BASE_URL`, `DB_PROVIDER`, `SQLITE_PATH` или `POSTGRES_URL`
  - `TRANSLATOR_PROVIDER`, ключи переводчика (`DEEPL_API_KEY`/`OPENAI_API_KEY`)
  - `TELEGRAM_SETUP_TOKEN`
- После первого деплоя вызовите setup URL для регистрации webhook в Telegram.
