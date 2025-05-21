`SizeReporter`: A widget that sets the ValueNotifier when the layout dimensions of its child change, and also when it's first assigned.
`SizeFollower`: A widget that renders a sizedbox around a child drawing from the given `ValueListenable<Size?>`.

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

Note, the follower will lag behind the actual size by one frame, which is very ugly in many situations. This is unavoidable. Flutter doesn't have complex layout resolution order planning, it just does things one after the other in a single pass, and that's probably how it should be, so that means there's no way to guarantee that one widget will know the size of another widget during layout, as it wont have always been calculated yet, so you'll be receiving the size from the previous frame.

Flutter used to have a widget like this (`SizeObserver`), then they modified that and made `SizeChangedLayoutNotifier`, which can't do `SizeObserver`/`SizeFollower` stuff, because I guess the project was embarassed about people misusing it in situations where the lag is visible.

I'd only recommend it in situations where the lag won't be visible, personally.

The motivating usecase was a drag and drop widget, where when a widget is dragged, it needs to leave behind an empty SizedBox of the same size as the widget being dragged, to keep layout in the container from jumping around. This seemed fine, but it turned out there was a better way of doing that, so we don't have any usecases for this right now, but maybe someone will find one one day, if you have found a use case, tell us about it in [the "we've got no usecases" issue](https://github.com/makoConstruct/size_follower/issues/1).
