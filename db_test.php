<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Database configuration
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'hotel_management';

// Test database connection
echo "<h2>Testing Database Connection</h2>";

try {
    $conn = new mysqli($host, $username, $password, $database);
    
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    echo "Connected to database successfully!<br>";
    
    // Check if tables exist
    $tables = [
        'Hotel', 'Rooms', 'Guest', 'Membership', 
        'Reservation', 'Staff', 'Service', 'Restaurant', 
        'Menu', 'Payment', 'Maintenance', 'HouseKeeping'
    ];
    
    echo "<h3>Checking Tables:</h3>";
    echo "<ul>";
    
    foreach ($tables as $table) {
        $result = $conn->query("SHOW TABLES LIKE '$table'");
        if ($result->num_rows > 0) {
            // Count records
            $countResult = $conn->query("SELECT COUNT(*) as count FROM $table");
            $count = $countResult->fetch_assoc()['count'];
            echo "<li>Table '$table' exists - $count records</li>";
        } else {
            echo "<li style='color:red;'>Table '$table' does NOT exist</li>";
        }
    }
    
    echo "</ul>";
    
    $conn->close();
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>