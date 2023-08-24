echo "Create docker Container"
docker compose up --build -d
echo "Add Firewall rule(Firewalld)"
firewall-cmd --add-port=8082/tcp --permanent
firewall-cmd --reload