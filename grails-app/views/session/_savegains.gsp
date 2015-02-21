<g:form url="[action: 'win']" class="form-horizontal" data-toggle="validator">
    <div class="modal fade" id="gainsModal" tabindex="-1" role="dialog" aria-labelledby="ourGainsModal"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title"><g:message code="session.save.gains"/> '${sessionInstance.name}'</h4>
                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label for="gains" class="col-sm-3 control-label"><g:message code="session.gains"
                                                                                     default="Gains"/> *</label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon">€</span>
                                <g:textField name="gains" required="" value="${sessionInstance.gains}"
                                             class="form-control" pattern="^([0-9.,])*"/>
                            </div>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

                    <g:hiddenField name="sessionId" value="${sessionInstance.id}"/>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><g:message
                            code="default.button.close.label"/></button>
                    <g:submitButton name="create" class="btn btn-success"
                                    value="${message(code: 'default.button.save.label', default: 'Save')}"/>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</g:form>