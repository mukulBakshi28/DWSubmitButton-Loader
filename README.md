# DWSubmitButton-Loader
By Changing the Subclass of UIButton to DWSubmitButton Loader Class and make it a loadable button with a progress value.Just change the class of UIButton to DWSubmitButton and make the class confirm to the DWSubmitButton delegates to implement its delegates. DWSubmit button has an iVar called "progress" which you can use to update the real time progress bar outside the button layer.

eg :-

```
   ** @IBOutlet weak var submitButton: DWSubmitButton! 

func downloadImageWithProgress(imgProgress:CGFloat) {
submitButton.progress = imgProgress
}
```
**

## Note -: The iVar "progress" is only called after the button Action 

You can also use the property **updatingDefaultProgressUntilDone** if you don't have the live progress eg while calling an api or making a request to a server through a web service , you can use this property to update the dummy progress like this :-

        submitButton.updatingDefaultProgressUntilDone = true

and after the response of an api call recieve ,you can remove the progress by using the property "completeDefaultProgress" like -:

**On Successful response of the service **
```
 submitButton.completeDefaultProgress = true
```
