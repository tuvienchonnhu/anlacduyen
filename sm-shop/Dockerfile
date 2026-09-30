# 1. Build Stage: Dùng Maven để đóng gói ứng dụng
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# 2. Run Stage: Sử dụng Tomcat runtime để chạy file WAR
FROM tomcat:9.0-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps/

# Xóa các app mặc định của Tomcat để nhẹ máy
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR từ build stage vào Tomcat
# LƯU Ý: Đổi 'ROOT.war' hoặc tên file war thực tế tạo ra trong thư mục target/
COPY --from=build /app/sm-shop/target/*.war ./ROOT.war

# Cloud Run yêu cầu ứng dụng lắng nghe qua cổng do biến môi trường $PORT cung cấp (mặc định 8080)
EXPOSE 8080

CMD ["catalina.sh", "run"]