A widget that sets the ValueNotifier when the layout dimensions of its child change, and also when it's first assigned.

Note, the follower will lag behind the actual size by one frame, which is very ugly in many situations. This is unavoidable. Flutter doesn't have complex layout resolution order planning, it just does things one after the other in a single pass, and that's probably how it should be, so that means there's no way to guarantee that one widget will know the size of another widget during layout, as it wont have always been calculated yet.

Flutter used to have a widget like this (`SizeObserver`), then they modified that and made `SizeChangedLayoutNotifier`, which can't do `SizeObserver`/`SizeFollower` stuff, because I guess the project was embarassed about people misusing it in situations where the lag is visible.

I only use it in situations where the lag isn't visible, personally. The motivating usecase was a drag and drop widget, where when a widget is dragged, it needs to leave behind an empty SizedBox of the same size as the widget being dragged, to keep layout in the container from jumping around. It's rare that the size of the widget being dragged changes mid-drag, so the size will start out correct and stay correct as long as it needs to, but even if it did change, you wouldn't notice the lag, since they'd be in quite different places on the screen.

```dart
ValueNotifier<Size?> sizeNotifier = ValueNotifier<Size?>(null);

...
SizeReporter(
    previousSize: sizeNotifier,
  child: ...,
)
...
SizeFollower(
    previousSize: sizeNotifier,
    child: ...,
)
```