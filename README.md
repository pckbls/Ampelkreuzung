This is a veery old school project of mine called Ampelkreuzung (German, intersection with traffic lights)
It simulates an intersection including traffic lights and cars.
It is written in Delphi/Free Pascal and was built with the free Lazarus IDE.

# Some background information

Back in those days I've played a lot with server side modding of Counter-Strike 1.6.
This project's code adapts some of the ideas and techniques found in the GoldSrc engine:
There's a world object, in my case an empty canvas that can be painted on.
The world consists of entities that are placed somewhere on the canvas and may be visible or invisible.
The engine uses *ticks* to make the world vivid.
Each tick the engine allows all entities to *think* thus make them do something.
Then the engine determines which entities overlap and allows them to handle touch events.
This way I was able to allow my car entities make more or less intelligent decisions, e.g.:
* All cars check if there's a car ahead of them. If so and the car ahead is driving slower, cars will attempt to lower their speed in order to avoid crashes.
* When a car touches a stop line entity and the associated traffic light is red, it will stop.
* When a car touches a rotator entity, the car shall change its direction.

# Screenshots/Videos

Here's a screenshot.
![screenshot](https://github.com/pckbls/Ampelkreuzung/raw/master/screenshot.png)

A video can be found on my old YouTube channel:
https://www.youtube.com/watch?v=xgJVyDzdWvg

