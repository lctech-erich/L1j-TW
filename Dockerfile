# 1. 使用包含 Java 8 的 Linux 環境作為基底
FROM openjdk:8-jdk

# 2. 由於專案很古老，我們在環境內安裝編譯工具 Ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

# 3. 設定伺服器在雲端運行的資料夾
WORKDIR /app

# 4. 把你 GitHub 所有的天堂程式碼複製進去
COPY . .

# 5. 執行 Ant 編譯，把 src 裡面的 Java 程式碼編成可以執行的檔案
RUN ant

# 6. 給予啟動腳本執行權限
RUN chmod +x ServerStart.sh

# 7. 開放網頁與遊戲連線的埠口 (天堂預設 2000, 網頁預設 8080)
EXPOSE 2000 8080

# 8. 正式啟動天堂伺服器
CMD ["./ServerStart.sh"]
