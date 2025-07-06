document.addEventListener('DOMContentLoaded', function() {
    const resultsContainer = document.getElementById('resultsContainer');
    const loadingIndicator = document.getElementById('loadingIndicator');
    const errorAlert = document.getElementById('errorAlert');
    const errorMessage = document.getElementById('errorMessage');
    const clearResultsBtn = document.getElementById('clearResults');
    const customQueryForm = document.getElementById('customQueryForm');
    const queryButtons = document.querySelectorAll('.query-btn');
    

    queryButtons.forEach(button => {
        button.addEventListener('click', function() {
            const queryType = this.getAttribute('data-query');
            const sectionType = this.getAttribute('data-type');
            executeQuery(sectionType, queryType);
        });
    });
    
    customQueryForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const query = document.getElementById('customQuery').value.trim();
        if (query) {
            executeCustomQuery(query);
        } else {
            showError('Please enter a valid SQL query.');
        }
    });
    
    clearResultsBtn.addEventListener('click', function() {
        clearResults();
    });
    
    function executeQuery(sectionType, queryType) {
        showLoading();
        
        hideError();
        
        $.ajax({
            url: 'execute_query.php',
            method: 'POST',
            data: {
                sectionType: sectionType,
                queryType: queryType
            },
            dataType: 'json',
            success: function(response) {
                hideLoading();
                
                displayResults(response);
            },
            error: function(xhr, status, error) {
                hideLoading();
                
                showError('Network error: ' + error);
            }
        });
    }
    
    function executeCustomQuery(query) {
        showLoading();
        
        hideError();
        
        $.ajax({
            url: 'execute_query.php',
            method: 'POST',
            data: {
                query: query
            },
            dataType: 'json',
            success: function(response) {
                hideLoading();
                
                displayResults(response);
            },
            error: function(xhr, status, error) {

                hideLoading();
                
                showError('Network error: ' + error);
            }
        });
    }
    
    function displayResults(response) {
        clearResults();
        
        if (!response.success) {
            showError(response.error);
            return;
        }
        
        if (response.message) {
            const messageElement = document.createElement('div');
            messageElement.className = 'alert alert-success';
            messageElement.innerHTML = `<i class="fas fa-check-circle me-2"></i>${response.message}`;
            resultsContainer.appendChild(messageElement);
            return;
        }
        
        if (response.data && response.data.length > 0) {
            // Create table
            const table = document.createElement('table');
            table.className = 'table table-striped table-hover';
            
            const thead = document.createElement('thead');
            const headerRow = document.createElement('tr');
            
            for (const column of response.columns) {
                const th = document.createElement('th');
                th.textContent = formatColumnName(column);
                headerRow.appendChild(th);
            }
            
            thead.appendChild(headerRow);
            table.appendChild(thead);
            
            const tbody = document.createElement('tbody');
            
            for (const row of response.data) {
                const tr = document.createElement('tr');
                
                for (const column of response.columns) {
                    const td = document.createElement('td');
                    
                    const value = row[column];
                    if (value === null) {
                        td.textContent = 'NULL';
                        td.className = 'text-muted';
                    } else if (typeof value === 'boolean') {
                        td.textContent = value ? 'Yes' : 'No';
                    } else if (isDateString(value)) {
                        td.textContent = formatDateTime(value);
                    } else {
                        td.textContent = value;
                    }
                    
                    tr.appendChild(td);
                }
                
                tbody.appendChild(tr);
            }
            
            table.appendChild(tbody);
            
            // Add table to results container
            resultsContainer.appendChild(table);
            
            // Add record count
            const recordCount = document.createElement('div');
            recordCount.className = 'mt-3 text-end text-muted small';
            recordCount.textContent = `${response.data.length} record(s) found`;
            resultsContainer.appendChild(recordCount);
        } else {
            // No data found
            const noDataElement = document.createElement('div');
            noDataElement.className = 'alert alert-info';
            noDataElement.innerHTML = '<i class="fas fa-info-circle me-2"></i>No records found.';
            resultsContainer.appendChild(noDataElement);
        }
    }
    
    function showLoading() {
        resultsContainer.classList.add('d-none');
        loadingIndicator.classList.remove('d-none');
    }
    
    function hideLoading() {
        loadingIndicator.classList.add('d-none');
        resultsContainer.classList.remove('d-none');
    }
    
    function showError(message) {
        errorMessage.textContent = message;
        errorAlert.classList.remove('d-none');
    }
    
    function hideError() {
        errorAlert.classList.add('d-none');
    }
    
    function clearResults() {
        resultsContainer.innerHTML = '';
        const emptyState = document.createElement('div');
        emptyState.className = 'text-center text-muted py-5';
        emptyState.innerHTML = `
            <i class="fas fa-database fa-3x mb-3"></i>
            <p>Select a query to view results</p>
        `;
        resultsContainer.appendChild(emptyState);
    }
    
    function formatColumnName(name) {
        return name
            .replace(/_/g, ' ')
            .replace(/\b\w/g, l => l.toUpperCase());
    }
    
    function isDateString(str) {
        if (typeof str !== 'string') return false;
        return /^\d{4}-\d{2}-\d{2}/.test(str);
    }
    
    function formatDateTime(dateString) {
        try {
            const date = new Date(dateString);
            if (isNaN(date.getTime())) {
                return dateString;
            }
            
            const options = {
                year: 'numeric',
                month: 'short',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            };
            
            return date.toLocaleDateString('en-US', options);
        } catch (e) {
            return dateString;
        }
    }
    
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
});