# Train-API

Offering a simple Swift API for real-time tain/travel-information.

## ICE API
This Swift Package has been developed to power [ICE Buddy](https://ice-buddy.riedel.wtf).

### On-Board Server
This Swift Package connects to the on-board server of ICE trains, so connecting to the WiFi@DB or WiFionICE is mandatory.

Then, REST-Requests are sent to the following endpoints:
- https://iceportal.de/api1/rs/status
- https://iceportal.de/api1/rs/tripInfo/trip

### Available Data Points
- Current speed (km/h)
- Train name and journey title (e.g., ICE 643: Düsseldorf Hbf -> Berlin Ostbahnhof)
- Train model (e.g., ICE 4)
- Train model image
- Journey (all train stations), incluing:
    - Track
    - Planned arrival time
    - Actual arrival time (delay)
- Current internet quality (stable / unstable)
     


## TGV, ÖBB, SBB CFF FFS?
We encourage all thrain enthusiasts from all over the world to contribute to this open-source project!
