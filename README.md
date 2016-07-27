ManualLayoutUtility
===================
Hoon H.
Eonil
2016/07/23

A set of utilities to help manual layout calculation.



Note
----
Don't forget that AppKit/UIKit text measuring algorithm prefer laying out text
horizontally. They will consume any available width before start to consider
to consume height.

This library assumes that you always measure before layout. Layout algorithm 
does not try to *stretch* or *shrink* measured view sizes. It just lays them
naively as measured. 

Measuring logic may introduce those some flexible layout behavior. 

Also, AppKit coordinate is Y-up based, so I need to write most of test code
twice.

You can use whatever feature that you want. If you're not sure on how to handle
`sizeThatFits(:)`, just wrap `CommonFeature`, and return values from it.
















