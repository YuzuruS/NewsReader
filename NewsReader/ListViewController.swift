//
//  ListViewController.swift
//  NewsReader
//
//  Created by yudsuzuk on 2016/06/28.
//  Copyright © 2016年 yudsuzuk. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, NSXMLParserDelegate {
    var parser:NSXMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
    
    func startDownload() {
        self.items = []
        if let url = NSURL(string: "http://feeds.lifehacker.jp/rss/lifehacker/index.xml"){
            if let parser = NSXMLParser(contentsOfURL: url) {
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
            }
        }
    }
    
    func parser(
        parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
                      attributes attributeDict: [String : String]
                ){
        self.currentString = ""
        if elementName == "item" {
            self.item = Item()
        }
        
    }
    
    func parser (
        parser: NSXMLParser,
        foundCharacters string: String
        ) {
        self.currentString += string
        
    }
    
    func parser(
        parser: NSXMLParser,
        didEndElement elementName: String,
                      namespaceURI: String?,
                      qualifiedName qName: String?
        ) {
        
        switch elementName {
            case "title": self.item?.title = currentString
            case "link": self.item?.link = currentString
            case "item": self.items.append(self.item!)
            default: break
         }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let item = items[indexPath.row]
            let controller = segue.destinationViewController as! DetailViewController
            controller.title = item.title
            controller.link = item.link
        }
    }
}

