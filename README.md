Features
--------

* Presents the user with a fully customizeable view for them to sign
* Returns a UIImage of the signature, cropped and centered to fit (with an optional margin)
* Example shows how to save signature to a PNG file
* Free!


Usage
-----

1. Add the files contained in the JBSignatureControllerSource directory to your project.
2. Initialize the JBSignatureController class:
    
    JBSignatureController *signatureController = [[JBSignatureController alloc] init];
    signatureController.delegate = self;
    [self presentModalViewController:signatureController animated:YES];
    
3. Implement the JBSignatureControllerDelegate protocol:
    
    // Called when the user clicks the confirm button (required)
    -(void)signatureConfirmed:(UIImage *)signatureImage signatureController:(JBSignatureController *)sender;
        
    // Called when the user clicks the cancel button (optional)
    -(void)signatureCancelled:(JBSignatureController *)sender;
    
    // Called when the user clears their signature or when clearSignature is called. (optional)
    -(void)signatureCleared:(UIImage *)clearedSignatureImage signatureController:(JBSignatureController *)sender;
    

Example
-------

See the example provided in the source code.


Contributing
------------

Feel free to submit pull requests!