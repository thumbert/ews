/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/DeleteRequest.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/Enumerations.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/misc/FolderIdWrapperList.dart';

/// <summary>
/// Represents an EmptyFolder request.
/// </summary>
class EmptyFolderRequest extends DeleteRequest<ServiceResponse> {
  FolderIdWrapperList _folderIds = new FolderIdWrapperList();

  bool _deleteSubFolders = false;

  /// <summary>
  /// Initializes a new instance of the <see cref="EmptyFolderRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  EmptyFolderRequest(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode) {}

  /// <summary>
  /// Validates request.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParam(this.FolderIds, "FolderIds");
    this.FolderIds.Validate(this.Service.RequestedServerVersion);
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return this.FolderIds.Count;
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service object.</returns>
  @override
  ServiceResponse CreateServiceResponse(
      ExchangeService service, int responseIndex) {
    return new ServiceResponse();
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.EmptyFolder;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.EmptyFolderResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name.</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.EmptyFolderResponseMessage;
  }

  /// <summary>
  /// Writes XML elements.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    this
        .FolderIds
        .WriteToXml(writer, XmlNamespace.Messages, XmlElementNames.FolderIds);
  }

  /// <summary>
  /// Writes XML attributes.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    writer.WriteAttributeValue(
        XmlAttributeNames.DeleteSubFolders, this.DeleteSubFolders);
  }

  /// <summary>
  /// Gets the request version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this request is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2010_SP1;
  }

  /// <summary>
  /// Gets the folder ids.
  /// </summary>
  /// <value>The folder ids.</value>
  FolderIdWrapperList get FolderIds => this._folderIds;

  /// <summary>
  /// Gets or sets a value indicating whether empty folder should also delete sub folders.
  /// </summary>
  /// <value><c>true</c> if empty folder should also delete sub folders, otherwise <c>false</c></value>
  bool get DeleteSubFolders => _deleteSubFolders;

  set DeleteSubFolders(bool value) => _deleteSubFolders = value;
}
