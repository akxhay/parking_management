# Parking management system flutter

The Parking Management System is a mobile application built with Flutter to manage parking lots and parking slots.
This system provides tools for creating, monitoring,
and managing parking lots, allocating parking slots, and keeping track of parked vehicles.

## Features

- **Parking Lot Management**: Create multi-level parking lots with dedicated slots catering to various car sizes.
- **Deletion of Parking Lots**: Effortlessly remove existing parking lots from the system.
- **Slot Availability**: Quickly identify available parking slots for accommodating new vehicles.
- **Slot Release**: Seamlessly release parking slots when they are no longer in use.

## Getting Started

These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install): Make sure you have Flutter installed.

### Installing

1. Clone the repository:

   ```shell
   git clone https://github.com/akxhay/parking_management.git
   ```

2. Change the working directory:

   ```shell
   cd parking_management
   ```

3. Get dependencies:

   ```shell
   flutter pub get
   ```

### Running the App

1. Ensure an emulator or a physical device is connected.
2. Run the app:

   ```shell
   flutter run
   ```

## Screenshots
```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Screenshots</title>
    <style>
        .screenshot-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-gap: 20px;
            justify-content: center;
        }
        .screenshot {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .image-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }
        .image-container img {
            border: 1px solid #ddd;
            border-radius: 4px;
            max-width: 100%;
            height: auto;
        }
        .description {
            margin: 10px 0;
            text-align: center;
            font-size: 14px;
            color: #333;
        }
    </style>
</head>
<body>
<div class="screenshot-grid">
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/app_icon.png" alt="app_icon">
            <p class="description">1. App Icon</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/splash.png" alt="splash">
            <p class="description">2. Splash screen</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/no_parking_lots.png" alt="no_parking_lots">
            <p class="description">3. No parking lot available</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/parking_lots_pageable.png" alt="parking_lots_pageable">
            <p class="description">4. Parking lots pageable list</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/add_parking_lot.png" alt="add_parking_lot">
            <p class="description">5. Add a new Parking lot by clicking on <b>(+) floating icon</b></p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/add_update_floor.png" alt="add_update_floor">
            <p class="description">6. Add or update a floor</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/updated_list.png" alt="updated_list">
            <p class="description">7. Updated list after adding a parking lot</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/delete_parking_lot.png" alt="delete_parking_lot">
            <p class="description">8. You can <b>swipe and delete</b> the parking slot</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/parking_lot_info.png" alt="parking_lot_info">
            <p class="description">9. Click on any item open parking lot information</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/pop_up_get_a_free_slot.png" alt="pop_up_get_a_free_slot">
            <p class="description">10. Click <b>(P) floating icon</b> to park a new car</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/chose_car_type.png" alt="chose_car_type">
            <p class="description">11. Choose a car type</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/enter_number_plate.png" alt="enter_number_plate">
            <p class="description">12. Enter number plate and click <b>'Park'</b></p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/parking_arrival_receipt.png" alt="parking_arrival_receipt">
            <p class="description">13. You will get an <b>arrival receipt</b> if there is any <b>available slot</b></p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/no_parking_slot.png" alt="no_parking_slot">
            <p class="description">14. There can be a situation where all slots are occupied</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/no_slot_error.png" alt="no_slot_error">
            <p class="description">15. You will get <b>error</b> while parking your car if <b>no slot</b> is available
            </p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/floor_info.png" alt="floor_info">
            <p class="description">16. Click on a floor to view size-wise parking slots. <b>Red indicates occupied</b>,
                and
                <b>White indicates available</b></p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/parking_departure_receipt.png" alt="parking_departure_receipt">
            <p class="description">17. Click on any occupied slot to get departure receipt with the <b>parking bill</b>
            </p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/free_medium_slot.png" alt="free_medium_slot">
            <p class="description">18. Released <b>medium</b> slot</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/free_slot_visible.png" alt="free_slot_visible">
            <p class="description">19. Free slot is available for a new car</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/try_park_large_car.png" alt="try_park_large_car">
            <p class="description">20. <b>Try</b> parking <b>a large car</b> in a medium slot</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/no_slot_for_size_error.png" alt="no_slot_for_size_error">
            <p class="description">21. You will <b>not</b> be able to get a <b>free slot</b></p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/try_smaller_car.png" alt="try_smaller_car">
            <p class="description">22. <b>Try</b> parking <b>a smaller car</b> in a medium slot</p>
        </div>
    </div>
    <div class="screenshot">
        <div class="image-container">
            <img src="screenshots/park_successful.png" alt="park_successful">
            <p class="description">23. You will be able to park <b>successfully</b></p>
        </div>
    </div>
</div>

</body>
</html>
```

Thank you. 😄

