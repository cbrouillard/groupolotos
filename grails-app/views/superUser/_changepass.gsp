<g:form url="[action: 'changepass']" class="form-horizontal" data-toggle="validator">
    <div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="ourPasswordModal"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title"><g:message code="admin.password.label"/></h4>
                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label for="password" class="col-sm-3 control-label"><g:message code="admin.password.new.label"
                                                                                        default="password"/> *</label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-star"></span></span>
                                <g:passwordField name="password" required="" class="form-control" data-minlength="6"/>
                            </div>
                            <span class="help-block"><g:message code="pass.minimum"/></span>
                        </div>
                    </div>

                    <div class="form-group">

                        <label for="password" class="col-sm-3 control-label"><g:message
                                code="admin.password.confirm.label"
                                default="password"/> *</label>

                        <div class="col-sm-9">
                            <div class="input-group">
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-star"></span></span>
                                <g:passwordField name="passwordCheck" required="" class="form-control"
                                                 data-match-error="${message(code:'pass.notmatch')}" data-match="#password"/>
                            </div>

                            <div class="help-block with-errors"></div>
                        </div>
                    </div>

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