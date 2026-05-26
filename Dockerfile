# 1. 使用 Java 8 環境
FROM eclipse-temurin:8-jdk

# 2. 【升級】除了安裝 Ant，順便安裝 Linux 專用的 7z 解壓縮工具（p7zip-full）
RUN apt-get update && apt-get install -y ant p7zip-full && rm -rf /var/lib/apt/lists/*

# 3. 設定工作目錄
WORKDIR /app

# 4. 複製所有程式碼進去
COPY . .

# 5. 【新增】核心魔法：自動在專案內尋找所有 .7z 檔案，並在原地解壓縮
RUN find . -name "*.7z" -type f -execdir 7z x -y {} \;

# 6. 執行 Ant 編譯 Java
RUN ant

# 7. 給予啟動腳本執行權限
RUN chmod +x ServerStart.sh

# 8. 開放埠口
EXPOSE 2000 8080

# 9. 啟動伺服器
CMD ["./ServerStart.sh"]
