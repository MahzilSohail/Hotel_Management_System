<?php

ini_set('display_errors', 0);
error_reporting(E_ALL);

require_once 'db_config.php';

header('Content-Type: application/json');
try {
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['query'])) {
        $query = $_POST['query'];
        $result = executeQuery($query);
        echo json_encode($result);
        exit;
    }
   
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['queryType']) && isset($_POST['sectionType'])) {
        $queryType = $_POST['queryType'];
        $sectionType = $_POST['sectionType'];
        
        $result = executeQueryByType($sectionType, $queryType);
        echo json_encode($result);
        exit;
    }
    
    echo json_encode([
        'error' => 'Invalid request',
        'success' => false
    ]);
} catch (Exception $e) {
    
    echo json_encode([
        'error' => 'Exception: ' . $e->getMessage(),
        'success' => false
    ]);
}

function executeQueryByType($sectionType, $queryType) {
    $queries = getQueriesMap();
    
    
    if (!isset($queries[$sectionType])) {
        return [
            'error' => 'Invalid section type',
            'success' => false
        ];
    }
    
    
    if (!isset($queries[$sectionType][$queryType])) {
        return [
            'error' => 'Invalid query type',
            'success' => false
        ];
    }
    
    
    return executeQuery($queries[$sectionType][$queryType]);
}

// Map of all predefined queries
function getQueriesMap() {
    return [
        'hotel' => [
            'getAllHotels' => "SELECT * FROM Hotel",
            'getHotelByLocation' => "SELECT * FROM Hotel WHERE Location LIKE '%Pakistan%'",
            'getHotelWithRooms' => "SELECT h.Hotel_Name, h.Location, COUNT(r.RoomID) as TotalRooms FROM Hotel h JOIN Rooms r ON h.Hotel_ID = r.Hotel_ID GROUP BY h.Hotel_ID",
            'getHighRatedHotels' => "SELECT * FROM Hotel WHERE Rating > 4.0"
        ],
        'room' => [
            'getAllRooms' => "SELECT * FROM Rooms",
            'getRoomsByType' => "SELECT * FROM Rooms WHERE RoomType = 'Suite'",
            'getAvailableRooms' => "
                SELECT r.* FROM Rooms r
                WHERE r.RoomID NOT IN (
                    SELECT res.RoomID FROM Reservation res
                    WHERE CURRENT_DATE BETWEEN DATE(res.CheckInDate) AND DATE(res.CheckOutDate)
                    AND res.Status = 'Confirmed'
                )
            ",
            'getRoomsByPrice' => "SELECT * FROM Rooms ORDER BY PricePerNight DESC"
        ],
        'guest' => [
            'getAllGuests' => "SELECT * FROM Guest",
            'getGuestWithMembership' => "SELECT g.*, m.MembershipType FROM Guest g JOIN Membership m ON g.MembershipID = m.Membership_ID",
            'getGuestsByNationality' => "SELECT * FROM Guest WHERE Nationality = 'Pakistan'",
            'getGuestsWithReservations' => "
                SELECT g.GuestID, g.FirstName, g.LastName, COUNT(r.Reservation_ID) as TotalReservations
                FROM Guest g
                JOIN Reservation r ON g.GuestID = r.GuestID
                GROUP BY g.GuestID
            "
        ],
        'reservation' => [
            'getAllReservations' => "SELECT * FROM Reservation",
            'getCurrentReservations' => "SELECT * FROM Reservation WHERE CURRENT_DATE BETWEEN DATE(CheckInDate) AND DATE(CheckOutDate)",
            'getReservationsByStatus' => "SELECT * FROM Reservation WHERE Status = 'Confirmed'",
            'getGuestReservations' => "
                SELECT r.*, g.FirstName, g.LastName 
                FROM Reservation r
                JOIN Guest g ON r.GuestID = g.GuestID
            "
        ],
        'staff' => [
            'getAllStaff' => "SELECT * FROM Staff",
            'getActiveStaff' => "SELECT * FROM Staff WHERE Status = 'Active'",
            'getStaffByPosition' => "SELECT * FROM Staff WHERE Position = 'Front Desk'",
            'getStaffSalaryReport' => "SELECT Position, AVG(Salary) as AverageSalary FROM Staff GROUP BY Position"
        ],
        'service' => [
            'getAllServices' => "SELECT * FROM Service",
            'getMaintenanceRecords' => "SELECT * FROM Maintenance",
            'getHousekeepingRecords' => "SELECT * FROM HouseKeeping",
            'getServicesByPrice' => "SELECT * FROM Service ORDER BY Price DESC"
        ],
        'restaurant' => [
            'getAllRestaurants' => "SELECT * FROM Restaurant",
            'getRestaurantMenu' => "
                SELECT r.Restaurant_name, m.Item_name, m.Category, m.Price 
                FROM Restaurant r
                JOIN Menu m ON r.Restaurant_id = m.Restaurant_id
            ",
            'getRestaurantByType' => "SELECT * FROM Restaurant WHERE Cuisine_type LIKE '%Indian%'",
            'getMenuItems' => "SELECT * FROM Menu ORDER BY Price ASC"
        ],
        'advanced' => [
            'revenueByRoom' => "
                SELECT r.RoomType, COUNT(res.Reservation_ID) as Bookings, SUM(res.TotalAmount) as Revenue
                FROM Rooms r
                JOIN Reservation res ON r.RoomID = res.RoomID
                GROUP BY r.RoomType
            ",
            'occupancyRate' => "
                SELECT 
                    COUNT(CASE WHEN res.Status = 'Confirmed' AND CURRENT_DATE BETWEEN DATE(res.CheckInDate) AND DATE(res.CheckOutDate) THEN 1 END) as OccupiedRooms,
                    (SELECT COUNT(*) FROM Rooms) as TotalRooms,
                    (COUNT(CASE WHEN res.Status = 'Confirmed' AND CURRENT_DATE BETWEEN DATE(res.CheckInDate) AND DATE(res.CheckOutDate) THEN 1 END) / (SELECT COUNT(*) FROM Rooms)) * 100 as OccupancyRate
                FROM Reservation res
            ",
            'topServices' => "
                SELECT s.Name, s.Price, COUNT(s.ServiceID) as TimesRequested
                FROM Service s
                GROUP BY s.ServiceID
                ORDER BY TimesRequested DESC
                LIMIT 5
            ",
            'paymentSummary' => "
                SELECT PaymentMethod, COUNT(Payment_ID) as TransactionCount, SUM(Amount) as TotalAmount
                FROM Payment
                GROUP BY PaymentMethod
            "
        ]
    ];
}
?>