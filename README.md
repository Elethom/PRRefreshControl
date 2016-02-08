# PRRefreshControl

[![CocoaPods](https://img.shields.io/cocoapods/v/PRRefreshControl.svg)](https://cocoapods.org/pods/PRRefreshControl)
[![Language](https://img.shields.io/badge/language-Objective--C-blue.svg)](../../search)
[![License](https://img.shields.io/github/license/Elethom/PRRefreshControl.svg)](/LICENSE)

[![Tweet](https://img.shields.io/twitter/url/http/ElethomHunter.svg?style=social)](https://twitter.com/intent/tweet?text=PRRefreshControl%3A%20Yet%20another%20and%20better%20refresh%20control%20for%20scroll%20views.&url=https%3A%2F%2Fgithub.com%2FElethom%2FPRRefreshControl&via=ElethomHunter)
[![Twitter](https://img.shields.io/twitter/follow/ElethomHunter.svg?style=social)](https://twitter.com/intent/follow?user_id=1512633926)

Yet another and better refresh control for scroll views.

## Installation

### With CocoaPods

In your `Podfile`:

```Ruby
pod 'PRRefreshControl'
```

## Usage

Setup in `-viewDidLoad` in your view controller class:

```Objective-C
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

```Objective-C
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

