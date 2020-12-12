const PRODUCTION = String.fromEnvironment('PRODUCTION', defaultValue: 'false') == 'true';
const API_URL = String.fromEnvironment('API_URL', defaultValue: 'localhost:8081');
const PROTOCOL = PRODUCTION ? 'https' : 'http';
const WEBSOCKET_PROTOCOL = PRODUCTION ? 'wss' : 'ws';
const BASE_URL = '$PROTOCOL://$API_URL';
