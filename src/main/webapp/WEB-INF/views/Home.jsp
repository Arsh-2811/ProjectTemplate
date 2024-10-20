<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expandable Side Panels with Search</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Main side panel styles (starts below navbar) */
        #sidePanel {
            height: calc(100% - 56px); /* Subtract navbar height */
            width: 0;
            position: fixed;
            top: 56px; /* Start below navbar */
            left: 0;
            background-color: #343a40;
            overflow-x: hidden;
            padding-top: 20px;
            z-index: 9999; /* Remove transition */
        }

        #subSidePanel {
            height: calc(100% - 56px); /* Subtract navbar height */
            width: 250px;
            position: fixed;
            top: 56px; /* Start below navbar */
            left: 250px;
            background-color: #495057;
            overflow-x: hidden;
            padding-top: 20px;
            z-index: 10000;
            display: none; /* Remove transition */
        }

        #sidePanel a, #subSidePanel a {
            padding: 10px 20px;
            text-decoration: none;
            font-size: 18px;
            color: #f8f9fa;
            display: block;
        }

        #sidePanel a:hover, #subSidePanel a:hover {
            background-color: #6c757d;
            color: white;
        }

        /* Right arrow next to expandable items */
        .expandable::after {
            content: ' \2192'; /* Unicode for right arrow */
            float: right;
            font-size: 16px;
        }

        /* Overlay to disable only the main content area (not the navbar) */
        #overlay {
            position: fixed;
            display: none;
            width: 100%;
            height: calc(100% - 56px); /* Subtract navbar height */
            top: 56px; /* Start overlay below navbar */
            left: 0;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9998;
        }

        /* Navbar custom styles */
        .navbar {
            background-color: #007bff;
            padding: 0.75rem 1.5rem;
        }

        /* Spacing for the hamburger icon */
        .navbar .icon-container {
            margin-right: 10px;
        }

        /* Spacing and alignment for the navbar brand */
        .navbar-brand {
            margin-left: 10px;
        }

        /* Spacing for the user info dropdown */
        .navbar-nav .nav-item .nav-link {
            margin-right: 15px;
        }

        /* Dropdown menu styling */
        .dropdown-menu {
            right: 0;
            left: auto;
            margin-top: 10px;
        }

        /* Hamburger and cross icon container */
        .icon-container {
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }

        /* Hamburger and cross icon size */
        .hamburger-icon, .cross-icon {
            font-size: 30px;
            color: white;
            display: inline-block;
        }

        /* Search bar styling */
        .search-bar {
            padding: 10px;
            width: calc(100% - 20px);
            margin-bottom: 10px;
            border: none;
            border-radius: 5px;
        }

        /* Main content styles */
        .container {
            padding-top: 40px;
        }

        .main-content {
            background-color: #f8f9fa;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        /* Smooth transition for the side panels */
        .sidepanel {
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.5);
        }

        /* Disable body scrolling when side panel is open */
        body.offcanvas-open {
            overflow: hidden;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <div class="icon-container" id="hamburgerMenu" onclick="openSidePanel()">
            <span class="hamburger-icon navbar-toggler-icon"></span> <!-- Same size for hamburger icon -->
        </div>
        <a class="navbar-brand ms-2" href="#">Your Brand</a>

        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <span class="navbar-text me-3">
                        Date: <%= new java.util.Date() %>
                    </span>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        User Info
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li><a class="dropdown-item" href="#">Settings</a></li>
                        <li><a class="dropdown-item" href="#">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Side panel -->
<div id="sidePanel" class="sidepanel">
    <!-- Search Bar -->
    <input type="text" id="searchBar" class="search-bar" onkeyup="searchSubSidePanel()" placeholder="Search...">
    <div id="mainPanelItems">
        <a href="#" class="expandable" onmouseover="openSubSidePanel('about')">About</a>
        <a href="#" class="expandable" onmouseover="openSubSidePanel('services')">Services</a>
        <a href="#" class="expandable" onmouseover="openSubSidePanel('contact')">Contact</a>
    </div>
    <!-- Search results will be shown here -->
    <div id="searchResults" style="display: none;"></div>
</div>

<!-- Sub side panel (Initially hidden) -->
<div id="subSidePanel" class="sidepanel">
    <!-- Sub side panel content dynamically changes based on the hovered link -->
    <div id="aboutPanel" style="display: none;">
        <a href="#">Team</a>
        <a href="#">Company</a>
        <a href="#">History</a>
    </div>
    <div id="servicesPanel" style="display: none;">
        <a href="#">Consulting</a>
        <a href="#">Support</a>
        <a href="#">Training</a>
    </div>
    <div id="contactPanel" style="display: none;">
        <a href="#">Email Us</a>
        <a href="#">Call Us</a>
        <a href="#">Visit Us</a>
    </div>
</div>

<!-- Overlay to disable rest of the page -->
<div id="overlay"></div>

<!-- Main content -->
<div class="container mt-4">
    <div class="main-content">
        <h1>Main Content Area</h1>
        <p>This is your main content area. It will be disabled when the side panel is opened.</p>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Function to open the side panel and disable only the main content area
    function openSidePanel() {
        document.getElementById("sidePanel").style.width = "250px";
        document.getElementById("overlay").style.display = "block";
        document.body.classList.add("offcanvas-open");
        document.getElementById("hamburgerMenu").innerHTML = '<span class="cross-icon">&times;</span>';
        document.getElementById("hamburgerMenu").setAttribute("onclick", "closeSidePanel()");
    }

    // Function to close the side panel and enable the main content area
    function closeSidePanel() {
        document.getElementById("sidePanel").style.width = "0";
        document.getElementById("subSidePanel").style.display = "none";
        document.getElementById("overlay").style.display = "none";
        document.body.classList.remove("offcanvas-open");
        document.getElementById("hamburgerMenu").innerHTML = '<span class="hamburger-icon navbar-toggler-icon"></span>';
        document.getElementById("hamburgerMenu").setAttribute("onclick", "openSidePanel()");
    }

    // Function to open the sub side panel and display relevant content
    function openSubSidePanel(panel) {
        var subSidePanel = document.getElementById("subSidePanel");
        subSidePanel.style.display = "block";

        // Hide all sub panels first
        var subPanels = document.querySelectorAll('#subSidePanel > div');
        subPanels.forEach(function(panel) {
            panel.style.display = 'none';
        });

        // Show the selected panel
        var selectedPanel = document.getElementById(panel + 'Panel');
        selectedPanel.style.display = 'block';
    }

    // Search function for the sub side panels
    function searchSubSidePanel() {
        var input, filter, subPanels, links, i, txtValue, searchResults;
        input = document.getElementById("searchBar");
        filter = input.value.toUpperCase();
        searchResults = document.getElementById("searchResults");
        searchResults.innerHTML = ""; // Clear previous search results

        // Close the sub side panel and hide main panel items during search
        document.getElementById("subSidePanel").style.display = "none";
        document.getElementById("mainPanelItems").style.display = "none";

        // If the search input is empty, reset to the normal side panel view
        if (filter === "") {
            document.getElementById("mainPanelItems").style.display = "block";
            searchResults.style.display = "none";
            return;
        }

        // Search across all sub-panel items and show matching results
        subPanels = document.querySelectorAll('#subSidePanel > div');
        subPanels.forEach(function(panel) {
            links = panel.getElementsByTagName("a");
            for (i = 0; i < links.length; i++) {
                txtValue = links[i].textContent || links[i].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    searchResults.style.display = "block"; // Show search results container
                    searchResults.appendChild(links[i].cloneNode(true)); // Add matching result
                }
            }
        });
    }
</script>
</body>
</html>