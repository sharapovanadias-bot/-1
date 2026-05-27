@echo off
IF NOT EXIST node_modules (
  echo Installing dependencies...
  call npm install
)
echo Starting LinguaTravel...
call npm run dev

