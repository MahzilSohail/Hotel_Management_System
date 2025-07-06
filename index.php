<!DOCTYPE html>
<html lang="en" data-bs-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.replit.com/agent/bootstrap-agent-dark-theme.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Your HTML content here -->
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery (required for AJAX) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS - correct path -->
    <script src="js/main.js"></script>
    <!-- Header -->
    <header class="bg-dark text-white py-4 mb-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-0"><i class="fas fa-hotel me-2"></i>Hotel Management System</h1>
                    <p class="mb-0 text-info">Database Query Interface</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <span class="badge bg-success"><i class="fas fa-database me-2"></i>Connected to Database</span>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <!-- Main Query Interface -->
        <div class="row">
            <!-- Sidebar Navigation -->
            <div class="col-md-3 mb-4">
                <div class="list-group">
                    <a href="#hotel-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-building me-2"></i> Hotel Queries
                    </a>
                    <a href="#room-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-door-open me-2"></i> Room Queries
                    </a>
                    <a href="#guest-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-user me-2"></i> Guest Queries
                    </a>
                    <a href="#reservation-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-calendar-check me-2"></i> Reservation Queries
                    </a>
                    <a href="#staff-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-users me-2"></i> Staff Queries
                    </a>
                    <a href="#service-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-concierge-bell me-2"></i> Service Queries
                    </a>
                    <a href="#restaurant-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-utensils me-2"></i> Restaurant Queries
                    </a>
                    <a href="#advanced-section" class="list-group-item list-group-item-action d-flex align-items-center">
                        <i class="fas fa-chart-line me-2"></i> Advanced Queries
                    </a>
                </div>
                
                <!-- Custom Query -->
                <div class="card mt-4">
                    <div class="card-header bg-primary text-white">
                        <i class="fas fa-code me-2"></i> Custom Query
                    </div>
                    <div class="card-body">
                        <form id="customQueryForm" action="execute_query.php" method="POST">
                            <div class="mb-3">
                                <label for="customQuery" class="form-label">SQL Query:</label>
                                <textarea class="form-control" id="customQuery" name="query" rows="5" placeholder="SELECT * FROM..."></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-play me-2"></i> Execute Query
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9">
                <!-- Results Display -->
                <div class="card mb-4">
                    <div class="card-header bg-info text-white d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-table me-2"></i> Query Results
                        </div>
                        <div>
                            <button id="clearResults" class="btn btn-sm btn-outline-light">
                                <i class="fas fa-trash-alt me-1"></i> Clear
                            </button>
                        </div>
                    </div>
                    <div class="card-body" id="resultsContainer">
                        <div class="text-center text-muted py-5">
                            <i class="fas fa-database fa-3x mb-3"></i>
                            <p>Select a query to view results</p>
                        </div>
                    </div>
                </div>
                
                <!-- Loading Indicator -->
                <div id="loadingIndicator" class="d-none">
                    <div class="d-flex justify-content-center align-items-center p-5">
                        <div class="spinner-border text-primary me-3" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <span>Executing query...</span>
                    </div>
                </div>
                
                <!-- Error Alert -->
                <div id="errorAlert" class="alert alert-danger d-none" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <span id="errorMessage"></span>
                </div>
                
                <!-- Hotel Queries Section -->
                <section id="hotel-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-building me-2"></i> Hotel Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="hotel" data-query="getAllHotels">
                                        <i class="fas fa-list me-2"></i> List All Hotels
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="hotel" data-query="getHotelByLocation">
                                        <i class="fas fa-map-marker-alt me-2"></i> Hotels in Pakistan
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="hotel" data-query="getHotelWithRooms">
                                        <i class="fas fa-door-open me-2"></i> Hotels with Room Count
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="hotel" data-query="getHighRatedHotels">
                                        <i class="fas fa-star me-2"></i> High Rated Hotels (>4)
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Room Queries Section -->
                <section id="room-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-door-open me-2"></i> Room Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-success w-100 query-btn" data-type="room" data-query="getAllRooms">
                                        <i class="fas fa-list me-2"></i> List All Rooms
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-success w-100 query-btn" data-type="room" data-query="getRoomsByType">
                                        <i class="fas fa-bed me-2"></i> Suite Rooms
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-success w-100 query-btn" data-type="room" data-query="getAvailableRooms">
                                        <i class="fas fa-check-circle me-2"></i> Available Rooms
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-success w-100 query-btn" data-type="room" data-query="getRoomsByPrice">
                                        <i class="fas fa-sort-amount-down me-2"></i> Rooms by Price (High to Low)
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Guest Queries Section -->
                <section id="guest-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-user me-2"></i> Guest Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="guest" data-query="getAllGuests">
                                        <i class="fas fa-list me-2"></i> List All Guests
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="guest" data-query="getGuestWithMembership">
                                        <i class="fas fa-id-card me-2"></i> Guests with Membership
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="guest" data-query="getGuestsByNationality">
                                        <i class="fas fa-flag me-2"></i> Pakistani Guests
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="guest" data-query="getGuestsWithReservations">
                                        <i class="fas fa-calendar-check me-2"></i> Guests with Reservation Count
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Reservation Queries Section -->
                <section id="reservation-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-calendar-check me-2"></i> Reservation Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-warning w-100 query-btn" data-type="reservation" data-query="getAllReservations">
                                        <i class="fas fa-list me-2"></i> List All Reservations
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-warning w-100 query-btn" data-type="reservation" data-query="getCurrentReservations">
                                        <i class="fas fa-calendar-day me-2"></i> Current Reservations
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-warning w-100 query-btn" data-type="reservation" data-query="getReservationsByStatus">
                                        <i class="fas fa-check-circle me-2"></i> Confirmed Reservations
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-warning w-100 query-btn" data-type="reservation" data-query="getGuestReservations">
                                        <i class="fas fa-user-check me-2"></i> Reservations with Guest Details
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Staff Queries Section -->
                <section id="staff-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-users me-2"></i> Staff Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-danger w-100 query-btn" data-type="staff" data-query="getAllStaff">
                                        <i class="fas fa-list me-2"></i> List All Staff
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-danger w-100 query-btn" data-type="staff" data-query="getActiveStaff">
                                        <i class="fas fa-user-check me-2"></i> Active Staff
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-danger w-100 query-btn" data-type="staff" data-query="getStaffByPosition">
                                        <i class="fas fa-user-tie me-2"></i> Front Desk Staff
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-danger w-100 query-btn" data-type="staff" data-query="getStaffSalaryReport">
                                        <i class="fas fa-money-bill-wave me-2"></i> Staff Salary Report
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Service Queries Section -->
                <section id="service-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-concierge-bell me-2"></i> Service & Maintenance Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-secondary w-100 query-btn" data-type="service" data-query="getAllServices">
                                        <i class="fas fa-list me-2"></i> List All Services
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-secondary w-100 query-btn" data-type="service" data-query="getMaintenanceRecords">
                                        <i class="fas fa-tools me-2"></i> Maintenance Records
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-secondary w-100 query-btn" data-type="service" data-query="getHousekeepingRecords">
                                        <i class="fas fa-broom me-2"></i> Housekeeping Records
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-secondary w-100 query-btn" data-type="service" data-query="getServicesByPrice">
                                        <i class="fas fa-sort-amount-down me-2"></i> Services by Price
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Restaurant Queries Section -->
                <section id="restaurant-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-utensils me-2"></i> Restaurant & Menu Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="restaurant" data-query="getAllRestaurants">
                                        <i class="fas fa-list me-2"></i> List All Restaurants
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="restaurant" data-query="getRestaurantMenu">
                                        <i class="fas fa-clipboard-list me-2"></i> Restaurant Menus
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="restaurant" data-query="getRestaurantByType">
                                        <i class="fas fa-hamburger me-2"></i> Indian Cuisine Restaurants
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-primary w-100 query-btn" data-type="restaurant" data-query="getMenuItems">
                                        <i class="fas fa-sort-amount-up me-2"></i> Menu Items by Price
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Advanced Queries Section -->
                <section id="advanced-section" class="mb-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white">
                            <i class="fas fa-chart-line me-2"></i> Advanced Queries
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="advanced" data-query="revenueByRoom">
                                        <i class="fas fa-chart-bar me-2"></i> Revenue by Room Type
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="advanced" data-query="occupancyRate">
                                        <i class="fas fa-percentage me-2"></i> Current Occupancy Rate
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="advanced" data-query="topServices">
                                        <i class="fas fa-trophy me-2"></i> Top 5 Services
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-outline-info w-100 query-btn" data-type="advanced" data-query="paymentSummary">
                                        <i class="fas fa-money-bill-wave me-2"></i> Payment Method Summary
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-hotel me-2"></i>Hotel Management System</h5>
                    <p class="small">A comprehensive database management interface for hotel operations.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="small text-muted">© 2023 Hotel Management System. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="js/main.js"></script>
</body>
</html>