DBParallaxMapTableView
======================

A TableView with a parallax style interactive MapView header.
MapView can be independently panned and zoomed. The DemoViewController contains an example of usage.

To use:
- Include the DBParallaxMapTableView.h and DBParallaxMapTableView.m
- Create:
```obj-c
    self.paralaxMapTableView = [[DBParalaxMapTableView alloc] initWithFrame:self.view.frame];
    self.paralaxMapTableView.delegate = self;
    self.paralaxMapTableView.dataSource = self;
    
    [self.view addSubview:self.paralaxMapTableView];
```

- Implement your desired TableViewDelegate and TableViewDataSource methods. Currently the following are supported, if more are required let me know or they should be simple to implement yourself.
```
	- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
	- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
	- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
	- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
	- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
	- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
	- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
```

![Default](/Screenshots/Screenshot1.png "Default")
![Default](/Screenshots/Screenshot2.png "Dragging")
