<?php
// Database configuration
$host = 'localhost';
$username = 'root'; 
$password = ''; 
$database = 'hotel_management';

// Create database connection
function connectDB() {
    global $host, $username, $password, $database;
    
    $conn = new mysqli($host, $username, $password, $database);
    
    // Check connection
    if ($conn->connect_error) {
        return false;
    }
    
    return $conn;
}

// Execute a query and return results
function executeQuery($query) {
    $conn = connectDB();
    
    if (!$conn) {
        return [
            'error' => 'Database connection failed',
            'success' => false
        ];
    }
    
    try {
        $result = $conn->query($query);
        
        // Check for query error
        if (!$result) {
            $conn->close();
            return [
                'error' => 'Query error: ' . $conn->error,
                'success' => false
            ];
        }
        
        // For SELECT queries
        if ($result instanceof mysqli_result) {
            $data = [];
            $columns = [];
            
            // Get column names
            $field_info = $result->fetch_fields();
            foreach ($field_info as $field) {
                $columns[] = $field->name;
            }
            
            // Get data
            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }
            
            $conn->close();
            return [
                'success' => true,
                'columns' => $columns,
                'data' => $data
            ];
        } 
        // For INSERT, UPDATE, DELETE queries
        else {
            $conn->close();
            return [
                'success' => true,
                'message' => 'Query executed successfully. Affected rows: ' . $conn->affected_rows
            ];
        }
    } catch (Exception $e) {
        $conn->close();
        return [
            'error' => 'Exception: ' . $e->getMessage(),
            'success' => false
        ];
    }
}
?>