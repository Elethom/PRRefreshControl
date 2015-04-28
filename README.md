# PRRefreshControl

[![Cocoapods](https://cocoapod-badges.herokuapp.com/v/PRRefreshControl/badge.png)](http://cocoapods.org/?q=PRRefreshControl)

## General

Yet another and better refresh control for scroll views.

## Installation

### With CocoaPods

In your `Podfile`:

```
pod 'PRRefreshControl'
```

## Usage

Setup in `-viewDidLoad` in your view controller class:

```
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ...
    
    PRRefreshControl *refreshControl = [[PRRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refreshControlTriggered:)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [collectionView insertSubview:refreshControl atIndex:0];
    
    // Configure manually if needed
    CGFloat customMarginTop = 10.f;
    refreshControl.scrollViewContentInset = collectionView.contentInset;
    refreshControl.height -= customMarginTop;
    refreshControl.verticalOffset = customMarginTop * .5f;
    
    ...
    
}
```

Respond to actions:

```
#pragma mark - Data

- (void)dataDidRefresh
{
    [self.refreshControl endRefreshing];
}

#pragma mark - Actions

- (void)refreshControlTriggered:(PRRefreshControl *)sender
{
    [self refreshData];
}
```

All done!

## License

This code is distributed under the terms and conditions of the [MIT license](http://opensource.org/licenses/MIT).

## Donate

You can support me by:

* sending me iTunes Gift Cards;
* via [Alipay](https://www.alipay.com): elethomhunter@gmail.com
* via [PayPal](https://www.paypal.com): elethomhunter@gmail.com

:-)

## Contact

* [About](https://about.me/elethom)
* [Telegram](https://telegram.org): [@elethom](http://telegram.me/elethom)
* [Email](mailto:elethomhunter@gmail.com)
* [Twitter](https://twitter.com/elethomhunter)
* [Blog](http://blog.projectrhinestone.org)

