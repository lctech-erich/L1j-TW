# 1. 使用 Java 8 環境
FROM eclipse-temurin:8-jdk

# 2. 【再次升級】除了 Ant 和 7z，順便把老舊的版本控制工具 subversion (內含 svnversion) 一起灌進去
RUN apt-get update && apt-get install -y ant p7zip-full subversion && rm -rf /var/lib/apt/lists/*

# 3. 設定工作目錄
WORKDIR /app

# 4. 複製所有程式碼進去
COPY . .

# 5. 自動在專案內尋找所有 .7z 檔案，並在原地解壓縮
RUN find . -name "*.7z" -type f -execdir 7z x -y {} \;

# 6. 執行 Ant 編譯 Java
RUN ant

# 7. 給予啟動腳本執行權限
RUN chmod +x ServerStart.sh

# 8. 開放埠口
EXPOSE 2000 8080

# 9. 啟動伺服器
CMD ["./ServerStart.sh"]
